class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update]
  before_action :identificate_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    if Profile.find_by(user_id: @user.id).present?
      @profile = Profile.find_by(user_id: @user.id)
    else
      @profile = Profile.new
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to profile_path(@profile.user.id), notice: "プロフィールを登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.user.id), notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :belonging, :self_introduction).merge(user_id: current_user.id)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def identificate_user
    redirect_to root_path if current_user.id != @profile.user_id
  end
end
