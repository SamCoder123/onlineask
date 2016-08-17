class Admin::AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def hide
    @answer = Answer.find(params[:id])
    @answer.hide!
    redirect_to :back, alert: "你隐藏了回答#{@answer.content}"
  end

  def publish
    @answer = Answer.find(params[:id])
    @answer.publish!
    redirect_to :back, alert: "你公开了回答#{@answer.content}"
  end
end
