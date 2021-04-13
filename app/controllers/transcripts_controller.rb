class TranscriptsController < ApplicationController
  before_action :set_transcript, only: [:show, :destroy]

  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = Transcript.new(transcript_params)
    if @transcript.save
      redirect_to root_path
      speech_async_recognize_gcs
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @transcript.destroy
    redirect_to root_path
  end

  private

  def transcript_params
    params.require(:transcript).permit(:name, :transcript, :status, :voice_data, :samplerate).merge(user_id: current_user.id)
  end

  def set_transcript
    @transcript = Transcript.find(params[:id])
  end

  def speech_async_recognize_gcs #Google Cloud Storageファイルの非同期音声文字変換
    require "google/cloud/speech"
    speech = Google::Cloud::Speech.speech

    storage_path = "gs://gijimemo_bucket/#{@transcript.voice_data.key}"
    config = { language_code:     "ja-JP",                     #言語設定：日本語
               encoding:          :ENCODING_UNSPECIFIED,       #エンコーディング：FLAC、WAVの時は省略可
               sample_rate_hertz: @transcript.samplerate.to_i, #サンプリングレート：FLAC、WAVの時は省略可
               enable_automatic_punctuation: true }            #句読点挿入機能
    audio = { uri: storage_path }
  
    operation = speech.long_running_recognize config: config, audio: audio
    operation.wait_until_done!
  
    results = operation.response.results
    @text = "音声文字変換結果："
    results.each do |result|
      alternatives = result.alternatives
      @text += "#{alternatives.first.transcript}"
    end

    if operation.error?
      @transcript.update_attributes(status: -1)
    else
      @transcript.update_attributes(status: 1, transcript: @text)
    end
  end
end
