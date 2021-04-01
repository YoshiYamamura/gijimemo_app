class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:edit, :update]

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

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:name, :meeting_date, :meeting_time, :place, :attendance, :speech).merge(user_id: current_user.id)
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

end
