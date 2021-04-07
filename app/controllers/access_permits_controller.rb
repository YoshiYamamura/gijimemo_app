class AccessPermitsController < ApplicationController
  def index
    @access_permits = AccessPermit.where(meeting: params[:meeting_id])
    @users = User.where.not(id: current_user.id)
    @access_permits.each do |access_permit|
      @users = @users.reject{|user| user.id == access_permit.user_id}
    end
    @meeting = Meeting.find(params[:meeting_id])
  end

  def create
    binding.pry
  end
end
