class AccessPermitsController < ApplicationController
  before_action :authenticate_user!
  before_action :access_permitted, only: [:index, :create]
  before_action :identificate_user

  def index
    @users = User.where.not(id: current_user.id)
    @access_permits.each do |access_permit|
      @users = @users.reject{|user| user.id == access_permit.user_id}
    end
    @meeting = Meeting.find(params[:meeting_id])
  end

  def create
    #共有設定ユーザーID preが更新前、postが更新後
    user_ids_pre = @access_permits.map{|access_permit| access_permit.user_id}
    user_ids_post = access_permit_params[:user_id].split(',').map{|id| id.to_i}
    #preに入っていて、postに入っていないユーザーは削除
    user_ids_pre.difference(user_ids_post).each do |user_id|
      access_permit = AccessPermit.find_by(user_id: user_id)
      access_permit.destroy
    end
    #postに入っていて、preに入っていないユーザーは追加
    user_ids_post.difference(user_ids_pre).each do |user_id|
      AccessPermit.create(user_id: user_id, meeting_id: access_permit_params[:meeting_id])
    end
  end

  private

  def access_permit_params
    params.permit(:user_id, :meeting_id)
  end

  def access_permitted
    @access_permits = AccessPermit.where(meeting: params[:meeting_id])
  end

  def identificate_user
    redirect_to root_path if current_user.id != Meeting.find(params[:meeting_id]).user_id
  end
end
