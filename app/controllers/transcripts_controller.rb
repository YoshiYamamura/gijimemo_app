class TranscriptsController < ApplicationController
  before_action :set_transcript, only: [:show, :destroy]
  before_action :identificate_user, only: [:show, :destroy]

  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = Transcript.new(transcript_params)
    if @transcript.save
      samplerate, channels = read_audiofile
      SpeechAsyncRecognizeJob.perform_later(@transcript, transcript_params[:language], samplerate, channels)
      redirect_to root_path, notice: "#{@transcript.name} を送信しました。完了までしばらくお待ちください。"
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @transcript.destroy
    redirect_to root_path, notice: "#{@transcript.name} を削除しました。"
  end

  private

  def transcript_params
    params.require(:transcript).permit(:name, :voice_data, :language).merge(user_id: current_user.id, transcript: "#", status: 0,)
  end

  def set_transcript
    @transcript = Transcript.find(params[:id])
  end

  def identificate_user
    redirect_to root_path if current_user.id != @transcript.user_id
  end

  def read_audiofile
    @transcript.voice_data.open do |audiofile|
      AudioInfo.open(audiofile) do |info|
        return info.info.duration.sample_rate, info.info.channels
      end
    end
  end
end
