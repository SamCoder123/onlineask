class Account::TagsController < AccountController
  layout "user_center"

  before_action :find_tag, only: %i(show, cancel)

  def index
    drop_breadcrumb("个人首页")
    drop_breadcrumb("兴趣标签")
    @tags = current_user.tags
  end

  def show
    drop_breadcrumb("个人首页")
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

  def find_tag
    @tag = Tag.find(params[:id])
  end

end
