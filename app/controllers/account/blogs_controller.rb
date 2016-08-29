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
    redirect_to :back
  end

  private
  def params_blog
    params.require(:blogs).permit(:title, :description)
  end
end
