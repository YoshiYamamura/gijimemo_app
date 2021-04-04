class ProfilesController < ApplicationController
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
      redirect_to profile_path(@profile), notice: "プロフィールを登録しました。"
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:family_name, :first_name, :belonging, :self_introduction).merge(user_id: current_user.id)
  end

end
