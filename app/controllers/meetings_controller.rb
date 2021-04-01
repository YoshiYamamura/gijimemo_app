class MeetingsController < ApplicationController
  before_action :authenticate_user!

  require "date"

  def index
    @meetings = Meeting.all
  end

  def new
    @meeting = Meeting.new
    @today = Date.today
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to root_path, notice: "議事録 #{@meeting.name}を登録しました。"
    else
      render :new
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:name, :meeting_date, :meeting_time, :place, :attendance, :speech).merge(user_id: current_user.id)
  end

end
