class WelcomeV1Controller < ApplicationController
  layout "welcome_v1"

  def index
    # @questions = Question.all
    @questions = Question.limit(6)

    # 记录上一次请求路径是否是登录或者注册
    flag = false

    flag = request.referer && ["/users/sign_in", "/users/sign_up"].include?(request.referer)

    # 如果上次请求是登录或注册，直接跳入个人首页。
    if flag & current_user
      if current_user.admin?
        redirect_to admin_admins_path
      else
        redirect_to show_profile_account_user_path(current_user)
      end
    end
  end
end
