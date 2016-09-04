class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_breadcrumbs
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_is_admin
    unless current_user.admin?
      flash[:alert] = "你没有管理员权限"
      redirect_to questions_path
    end
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  def drop_breadcrumb(title = nil, url = nil)
    title ||= @page_title

    if title && url
      @breadcrumbs.push(view_context.link_to(title, url))
    elsif title
      @breadcrumbs.push(title)
    end
  end

  # 定义全局变量@hot_questions
  helper_method :hot_questions

  def hot_questions
    @hot_questions = Question.order("watches DESC").limit(6)
  end

  # 定义全局变量@hot_replyers
  helper_method :hot_replyers

  def hot_replyers
    @hot_replyers = User.order("fans_num DESC").limit(6)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource_or_scope)
    show_profile_account_user_path(current_user)
  end
end
