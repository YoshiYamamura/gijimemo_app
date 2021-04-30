class TranscriptsController < ApplicationController
  before_action :set_transcript, only: [:show, :destroy]
  before_action :identificate_user, only: [:show, :destroy]

  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = Transcript.new(transcript_params)
    if @transcript.save
      read_audiofile
      SpeechAsyncRecognizeJob.perform_later(@transcript, transcript_params[:language], transcript_params[:number_of_people].to_i, @samplerate, @channels)
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
    params.require(:transcript).permit(:name, :voice_data, :language, :number_of_people).merge(user_id: current_user.id, transcript: "#", status: 0,)
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
        case info.extension
        when "wav"
          @samplerate = info.info.sample_rate
          @channels = info.info.channels
        when "mp3"
          @samplerate = info.info.samplerate
          case info.info.channel_mode
          when "Single Channel"
            @channels = 1
          when "Stereo", "JStereo"
            @channels = 2
          end
        when "flac"
          flacinfo = FlacInfo.new(audiofile)
          @samplerate = flacinfo.streaminfo.samplerate
          @channels = flacinfo.streaminfo.channels
        end
      end
    end
  end
end
