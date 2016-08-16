class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def hide
    @question = Question.find(params[:id])
    @question.is_hidden = true
    @question.save
    redirect_to :back, alert: "你隐藏了问题#{@question.title}"
  end

  def publish
    @question = Question.find(params[:id])
    @question.is_hidden = false
    @question.save
    redirect_to :back, alert: "你公开了问题#{@question.title}"
  end
end
