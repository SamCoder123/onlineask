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
<<<<<<< HEAD
    @question.hide!
    redirect_to :back, alert: "你隐藏了问题#{@question.title}"
=======
    @question.is_hidden = true
    @question.save
    flash[:alert] = "你隐藏了问题#{@question.title}"
    redirect_to :back
>>>>>>> xdite-refactor-0817
  end

  def publish
    @question = Question.find(params[:id])
<<<<<<< HEAD
    @question.publish!
    redirect_to :back, alert: "你公开了问题#{@question.title}"
=======
    @question.is_hidden = false
    @question.save
    flash[:alert] = "你公开了问题#{@question.title}"
    redirect_to :back
>>>>>>> xdite-refactor-0817
  end
end
