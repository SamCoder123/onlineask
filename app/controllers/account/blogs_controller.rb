class Account::BlogsController < AccountController
  layout "user_center"

  def index
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的动态")
    @blogs = Blog.all.order("id DESC").paginate(:page => params[:page], :per_page => 6)
  end

  def new
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的动态")
    drop_breadcrumb("新增动态")
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params_blog)
    @blog.user = current_user
    @blog.save
    redirect_to account_blogs_path
  end

  def edit
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的动态")
    drop_breadcrumb("编辑动态")
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(params_blog)
    redirect_to account_blogs_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to account_blogs_path
  end

  def ta_blogs
    drop_breadcrumb("Ta的动态")
    @user = User.find(params[:id])
    @blogs = @user.blogs.paginate(:page => params[:page], :per_page => 6)
  end

  private

  def params_blog
    params.require(:blog).permit(:title, :description)
  end
end
