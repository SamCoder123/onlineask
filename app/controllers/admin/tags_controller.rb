class Admin::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_tag, only: %i(show edit update destroy)

  layout "admin"

  def index
    drop_breadcrumb("标签管理")
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    drop_breadcrumb("标签管理")
    drop_breadcrumb("标签详情")
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @questions = Question.tagged_with(@tag.name)
  end

  def new
    drop_breadcrumb("标签管理")
    drop_breadcrumb("新增标签")
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:notice] = "标签新增成功！"
      redirect_to admin_tags_path
    else
      render :back
    end
  end

  def edit
    drop_breadcrumb("标签管理")
    drop_breadcrumb("编辑标签")
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = "标签修改成功！"
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    flash[:notice] = "标签删除成功！"
    redirect_to :back
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
