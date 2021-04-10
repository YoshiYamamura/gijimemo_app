class TranscriptsController < ApplicationController
  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = Transcript.new(transcript_params)
    if @transcript.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @transcript = Transcript.find(params[:id])
  end

  private

  def transcript_params
    params.require(:transcript).permit(:name, :transcript, :status, :voice_data).merge(user_id: current_user.id)
  end
end
