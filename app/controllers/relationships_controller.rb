class RelationshipsController < ApplicationController
  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to request.referer 
  end
end
