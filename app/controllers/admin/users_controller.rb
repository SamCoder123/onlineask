class Admin::UsersController < AdminController
  def index
    @users = User.all
    drop_breadcrumb("后台首页", admin_user_path(current_user))
    drop_breadcrumb("用户管理")
  end

  def change_to_user
    @user = User.find(params[:id])
    @user.change_to_user!
    redirect_to :back
  end

  def approved
    @user = User.find(params[:id])
    @user.approved!
    redirect_to :back
  end

  # applied
  # approved
  def change_to_admin
    @user = User.find(params[:id])
    @user.change_to_admin!
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
