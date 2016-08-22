class Account::FollowsController < ApplicationController
  # followee 是被关注的人，如xdite
  def like
    @followee = User.find(params[:id])

    if !current_user.already_follower?(@followee)
      current_user.follow!(@followee)
    else
      current_user.stop_follow!(@followee)
    end
    redirect_to :back
  end
end
