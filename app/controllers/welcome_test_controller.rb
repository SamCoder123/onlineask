class WelcomeTestController < ApplicationController
  layout "welcome_test"

  def index
    # @questions = Question.all
    @questions = Question.limit(6)

    #记录上一次请求路径是否是登录或者注册
    flag = false
    unless request.referrer==nil
      if request.referrer.include?('/users/sign_in') || request.referrer.include?('/users/sign_up')
        flag = true
      end
    end

    # 如果上次请求是登录或注册，直接跳入个人首页。
    if flag
      if current_user.admin?
        redirect_to admin_admins_path
      else
        redirect_to show_profile_account_user_path(current_user)
      end
    end
  end
end
