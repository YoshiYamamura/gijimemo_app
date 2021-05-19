class SpeechAsyncRecognizeJob < ApplicationJob
  queue_as :default

  def perform(transcript, language, number_of_people, samplerate, channels)
    require "google/cloud/speech"
    speech = Google::Cloud::Speech.speech
    begin
      storage_path = "gs://gijimemo_bucket/#{transcript.voice_data.key}"

      config = {
        language_code:                           language,              #言語設定：日本語または英語
        encoding:                                :ENCODING_UNSPECIFIED, #エンコーディング：FLAC、WAVの時は省略可
        sample_rate_hertz:                       samplerate,            #サンプリングレート：FLAC、WAVの時は省略可
        audio_channel_count:                     channels,              #チャンネル数（モノラル・ステレオ）
        enable_separate_recognition_per_channel: true,                  #チャンネル毎に認識
        enable_automatic_punctuation:            true                   #句読点挿入機能
      }
      #話者が複数人の場合、話者認識機能をONにする
      if number_of_people != 1
        diarization_config = {
          enable_speaker_diarization:            true,                  #話者毎に認識
          max_speaker_count:                     number_of_people,      #話者の最大人数
          min_speaker_count:                     number_of_people       #話者の最小人数
        }
        config[:diarization_config] = diarization_config
      end
      audio = { uri: storage_path }

      operation = speech.long_running_recognize config: config, audio: audio
      operation.wait_until_done!

      results = operation.response.results
      text = "音声文字変換結果："
  
      before_channel_number = 0 if channels != 1
      before_speaker_number = 0 if number_of_people != 1
      
      results.each do |result|
        alternatives = result.alternatives
        this_channel_number = result.channel_tag if channels != 1
  
        if number_of_people != 1
          #話者が複数人（話者認識機能ON）の場合、word単位で話者を確認して出力
          wordsinfo = alternatives.first.words
          wordsinfo.each do |wordinfo|
            this_speaker_number = wordinfo.speaker_tag
            if this_speaker_number != 0
              #speaker_tagが0の情報は、話者を識別していないtranscript単位の情報のため無視する
              if (before_channel_number != this_channel_number) && channels != 1
                #ステレオ音声の場合、チャンネルの変わり目に区切りを挿入
                text += "\n===== Channel No.#{this_channel_number} =====\n"
                before_channel_number = this_channel_number
                before_speaker_number = 0
              end
              if language == "ja-JP"
                #日本語は「かな漢字変換|カタカナ」の形式、かな漢字のみ抽出する
                word_text = wordinfo.word.split(sep="|")[0]
              else
                #英語はwordの前にスペースを挿入
                word_text = " " + wordinfo.word
              end
              text += "\nSpeaker No.#{this_speaker_number}：" if before_speaker_number != this_speaker_number
              before_speaker_number = this_speaker_number
              text += word_text
            end
          end
        else
          #話者が１人（話者認識機能OFF）の場合、transcript単位で出力
          if (before_channel_number != this_channel_number) && channels != 1
            #ステレオ音声の場合、チャンネルの変わり目に区切りを挿入
            text += "\n===== Channel No.#{this_channel_number} =====\n"
            before_channel_number = this_channel_number
          end
          text += "#{alternatives.first.transcript}"
        end
      end
      transcript.update(status: 1, transcript: text)
    rescue => e
      text = "エラーが発生しました：\n#{e.class}\n#{e.message}"
      transcript.update(status: -1, transcript: text)
    end
  end
end
