class Vote::VoteAnswersController < ApplicationController
  def like
    @answer = Answer.find(params[:id])
    @user = current_user
    if !@user.already_like?(@answer)
      @user.like!(@answer)
    else
      @user.like_cancel!(@answer)
    end
      redirect_to :back
  end

  def unlike
    @answer = Answer.find(params[:id])
    @user = current_user
    if !@user.already_unlike?(@answer)
      @user.unlike!(@answer)
    else
      @user.unlike_cancel!(@answer)
    end
      redirect_to :back
  end


end
