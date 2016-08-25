class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"

  def index
    @questions = Question.all
    drop_breadcrumb("问题管理")

  end

  def show
    @question = Question.find(params[:id])
    drop_breadcrumb("问题管理", admin_questions_path)
    drop_breadcrumb(@question.title)
  end

  def hide
    @question = Question.find(params[:id])
    @question.hide!
    flash[:alert] = "你隐藏了问题#{@question.title}"
    redirect_to :back
  end

  def publish
    @question = Question.find(params[:id])
    @question.publish!
    flash[:alert] = "你公开了问题#{@question.title}"
    redirect_to :back
  end
end
