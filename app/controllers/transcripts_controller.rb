class TranscriptsController < ApplicationController
  before_action :set_transcript, only: [:show, :destroy]
  before_action :identificate_user, only: [:show, :destroy]

  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = Transcript.new(transcript_params)
    if @transcript.save
      SpeechAsyncRecognizeJob.perform_later(@transcript, transcript_params[:samplerate], transcript_params[:language])
      redirect_to root_path
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
    params.require(:transcript).permit(:name, :voice_data, :samplerate, :language).merge(user_id: current_user.id, transcript: "#", status: 0,)
  end

  def set_transcript
    @transcript = Transcript.find(params[:id])
  end

  def identificate_user
    redirect_to root_path if current_user.id != @transcript.user_id
  end
end
