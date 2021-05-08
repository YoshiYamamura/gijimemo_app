class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:edit, :update, :destroy, :show]
  before_action :set_this_year, only: [:new, :create, :edit, :update]
  before_action :identificate_user, only: [:edit, :update, :destroy]

  require "date"

  def index
    #本人が作成した議事録
    @my_meetings = Meeting.where(user: current_user.id).order("meeting_date DESC").page(params[:my_meetings_page]).per(5)
    #共有設定された議事録
    access_permits = AccessPermit.where(user: current_user.id)
    meetings = []
    access_permits.each do |access_permit|
      meetings << access_permit.meeting_id
    end
    @permitted_meetings = Meeting.where(id: meetings).order("meeting_date DESC").page(params[:permitted_meetings_page]).per(5)
    #文字起こしデータ
    @transcripts = Transcript.where(user: current_user.id).order("created_at DESC").page(params[:transcripts_page]).per(5)
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to root_path, notice: "#{@meeting.name} を新規作成しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to root_path, notice: "#{@meeting.name} を編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    redirect_to root_path, notice: "#{@meeting.name} を削除しました。"
  end

  def show
    access_permitted_user
    @reaction = Reaction.new
    @reactions = @meeting.reactions.includes(:user)
  end

  def search
    #本人が作成した議事録
    @my_meetings = Meeting.where(user: current_user.id).search(params[:keyword]).order("meeting_date DESC").page(params[:my_meetings_page]).per(5)
    #共有設定された議事録
    access_permits = AccessPermit.where(user: current_user.id)
    meetings = []
    access_permits.each do |access_permit|
      meetings << access_permit.meeting_id
    end
    @permitted_meetings = Meeting.where(id: meetings).order("meeting_date DESC").page(params[:permitted_meetings_page]).per(5)
    #文字起こしデータ
    @transcripts = Transcript.where(user: current_user.id).order("created_at DESC").page(params[:transcripts_page]).per(5)
    render :index
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
