class Account::TagsController < AccountController
  layout "user_center"

  before_action :find_tag, only: %i(show, cancel)

  def index
    drop_breadcrumb("首页")
    drop_breadcrumb("兴趣标签")
    @tags = current_user.tags
    @hot_tags = Tag.where.not(id:@tags)
  end

  def show
    drop_breadcrumb("首页")
    drop_breadcrumb("兴趣标签")
    drop_breadcrumb("标签详情")
    @tag = current_user.tags.find(params[:id])
  end

  def cancel
    current_user.tag_list.remove(@tag.name)
    current_user.save
    flash[:alert] = "已经取消了～"
    redirect_to account_tags_path
  end

  def add_tag
    @tag = Tag.find(params[:id])
    current_user.tag_list.add(@tag.name)
    current_user.save
    redirect_to :back
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end

end
