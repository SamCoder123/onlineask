class Admin::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def index
    @answers = Answer.all
    render layout: "admin"
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def hide
    @answer = Answer.find(params[:id])
    @answer.hide!
    flash[:alert] = "你隐藏了回答#{@answer.content}"
    redirect_to :back
  end

  def publish
    @answer = Answer.find(params[:id])
    @answer.publish!
    flash[:alert] = "你公开了回答#{@answer.content}"
    redirect_to :back
  end
end
