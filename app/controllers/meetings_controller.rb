class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:edit, :update, :destroy, :show]
  before_action :set_this_year, only: [:new, :create, :edit, :update]
  before_action :identificate_user, only: [:edit, :update, :destroy]

  require "date"

  def index
    @my_meetings = Meeting.where(user: current_user.id)
    @permitted_meetings = []
    access_permits = AccessPermit.where(user: current_user.id)
    access_permits.each do |access_permit|
      @permitted_meetings << Meeting.find(access_permit.meeting_id)
    end
    @transcripts = Transcript.where(user: current_user.id)
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
    access_permitted_user
    @reaction = Reaction.new
    @reactions = @meeting.reactions.includes(:user)
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

  def identificate_user
    redirect_to root_path if current_user.id != @meeting.user_id
  end

  def access_permitted_user
    access_permits = AccessPermit.where(meeting: params[:id])
    @permitted_users = []
    result = 0
    access_permits.each do |access_permit|
      @permitted_users << User.find(access_permit.user_id)
      result = 1 if current_user.id == access_permit.user_id
    end
    result = 1 if current_user.id == @meeting.user_id
    redirect_to root_path if result != 1
  end
end
