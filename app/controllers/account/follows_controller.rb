class Account::FollowsController < ApplicationController
  # followee 是被关注的人，如xdite
  def like
    @followee = User.find(params[:id])

    if !current_user.already_follower?(@followee)
      current_user.follow!(@followee)
    else
      flash[:warning] = "You have already followed him/her!"
    end
    redirect_to :back
  end
end
