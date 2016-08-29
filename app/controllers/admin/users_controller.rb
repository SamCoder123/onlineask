class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"

  def index
    @users = User.all
    drop_breadcrumb("后台首页", admin_user_path(current_user))
    drop_breadcrumb("用户管理")
  end

  def change_to_admin
    @user = User.find(params[:id])
    @user.change_to_admin!
    redirect_to :back
  end

  def change_to_user
    @user = User.find(params[:id])
    @user.change_to_user!
    redirect_to :back
  end

  private

  def require_is_admin
    unless current_user.admin?
      flash[:alert] = "对不起，你没有管理员权限。"
      redirect_to root_path
    end
  end
end
