class WelcomeV1Controller < ApplicationController
  layout "welcome_v1"

  layout:false,only: [:register_guide]

  def index
    # @questions = Question.all
    @questions = Question.limit(6)

    # 记录上一次请求路径是否是登录或者注册
    flag = request.referer && request.referer.include?("/users/sign_up")

    # 注册页进入guide页面
    if flag
      #redirect_to register_guide_welcome_test_index_path
      redirect_to register_guide_welcome_test_index_path
      return
    end

    flag = request.referer && request.referer.include?("/users/sign_in")

    # 如果上次请求是登录或注册，直接跳入个人首页。
    if flag & current_user
      if current_user.admin?
        redirect_to admin_admins_path
      else
        redirect_to account_questions_path
      end
    end
  end

  def register_guide
    @tags = Tag.all
  end
end
