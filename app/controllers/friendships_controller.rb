class FriendshipsController < ApplicationController
  def create
    friend = User.where(id: params[:id]).first
    if (!friend.nil?)
      current_user.friends << friend
      flash[:notice] = "Started following #{friend.fullname}"
      redirect_to friends_path
    end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Stopped following"
    redirect_to friends_path
  end
end
