class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:edit, :update, :destroy, :show]
  before_action :set_this_year, only: [:new, :create, :edit, :update]

  require "date"

  def index
    @my_meetings = Meeting.where(user: current_user.id)
  end

  def new
    @meeting = Meeting.new
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

  def destroy
    @meeting.destroy
    redirect_to root_path
  end

  def show
  end

  private

  def meeting_params
    params.require(:meeting).permit(:name, :meeting_date, :meeting_time, :place, :attendance, :speech).merge(user_id: current_user.id)
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def set_this_year
    @this_year = Date.today.year
  end

end
