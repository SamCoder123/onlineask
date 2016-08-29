class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_breadcrumbs

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
end
