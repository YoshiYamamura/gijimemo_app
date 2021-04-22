class SpeechAsyncRecognizeJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError, ArgumentError, NoMethodError) do |e|
    text = "エラーが発生しました：\n#{e.message}"
    transcript.update(status: -1, transcript: text)
    exit
  end

  def perform(transcript, language, samplerate, channels)
    require "google/cloud/speech"
    speech = Google::Cloud::Speech.speech

    storage_path = "gs://gijimemo_bucket/#{transcript.voice_data.key}"
    config = { language_code:       language,                 #言語設定：日本語または英語
               encoding:            :ENCODING_UNSPECIFIED,    #エンコーディング：FLAC、WAVの時は省略可
               sample_rate_hertz:   samplerate,               #サンプリングレート：FLAC、WAVの時は省略可
               audio_channel_count: channels,                 #チャンネル数（モノラル・ステレオ）
               enable_separate_recognition_per_channel: true, #チャンネル毎に認識
               enable_automatic_punctuation: true }           #句読点挿入機能
    audio = { uri: storage_path }

    operation = speech.long_running_recognize config: config, audio: audio
    operation.wait_until_done!
    raise operation.results.message if operation.error?

    results = operation.response.results
    text = "音声文字変換結果："

    if channels == 1
      #モノラル音声の場合
      results.each do |result|
        alternatives = result.alternatives
        text += "#{alternatives.first.transcript}"
      end
    else
      #ステレオ音声の場合：チャンネル毎に区切って出力
      before_channel_number = 0
      results.each do |result|
        this_channel_number = result.channel_tag
        alternatives = result.alternatives
        if before_channel_number == this_channel_number
          text += "#{alternatives.first.transcript}"
        else
          text += "\nNo.#{this_channel_number}：#{alternatives.first.transcript}"
        end
        before_channel_number = this_channel_number
      end
    end

    transcript.update(status: 1, transcript: text)
  end
end
