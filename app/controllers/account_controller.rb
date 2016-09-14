class AccountController < ApplicationController
  before_action :public_replyers_redirect
  before_action :authenticate_user!

  def public_replyers_redirect

    flag = request.referer && request.referer.include?("/questions/public_replyers")

    # 跳转外层show_replyer页面
    if flag
      @user = User.find(params[:id])
      redirect_to show_replyer_questions_path(user_id:@user)
      return
    end
  end
end
