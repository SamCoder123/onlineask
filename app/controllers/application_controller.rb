class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    unless current_user.admin?
      flash[:alert] = '你没有管理员权限'
      redirect_to questions_path
    end
  end
end
