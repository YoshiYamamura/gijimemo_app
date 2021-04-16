class ReactionsController < ApplicationController

  def create
    reaction = Reaction.create(reaction_params)
    redirect_to meeting_path(reaction.meeting.id)
  end
  
  def destroy
    reaction = Reaction.find(params[:id])
    redirect_to root_path if current_user.id != reaction.user_id
    reaction.destroy
    redirect_to meeting_path(reaction.meeting.id)
  end

  private

  def reaction_params
    params.require(:reaction).permit(:comment).merge(user_id: current_user.id, meeting_id: params[:meeting_id])
  end
end
