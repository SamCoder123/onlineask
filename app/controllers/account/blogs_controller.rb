class Account::BlogsController < AccountController
  layout "user_center"

  def index
    drop_breadcrumb("个人首页", account_questions_path)
    drop_breadcrumb("我的动态")
    @blogs = Blog.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 6)
  end

  def new
    drop_breadcrumb("个人首页", account_questions_path)
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
    drop_breadcrumb("个人首页", account_questions_path)
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

  private

  def params_blog
    params.require(:blog).permit(:title, :description)
  end
end
