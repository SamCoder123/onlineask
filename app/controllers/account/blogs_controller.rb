class Account::BlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @blogs = Blog.all.order("created_at DESC")
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params_blog)
    @blog.user = current_user
    @blog.save
    redirect_to account_blogs_path
  end

  def edit
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
