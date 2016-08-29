class Account::FollowsController < ApplicationController
  # followee 是被我关注的人，如xdite
  def like
    @followee = User.find(params[:id])

    if !current_user.already_follower?(@followee)
      current_user.follow!(@followee)
      flash[:notice] = "您已成功关注#{@followee.name}"
    else
      current_user.stop_follow!(@followee)
    end
    redirect_to :back
  end
end
