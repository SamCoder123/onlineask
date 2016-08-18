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
<<<<<<< HEAD
    @answer.hide!
    redirect_to :back, alert: "你隐藏了回答#{@answer.content}"
=======
    @answer.is_hidden = true
    @answer.save
    flash[:alert] = "你隐藏了回答#{@answer.content}"
    redirect_to :back
>>>>>>> xdite-refactor-0817
  end

  def publish
    @answer = Answer.find(params[:id])
<<<<<<< HEAD
    @answer.publish!
    redirect_to :back, alert: "你公开了回答#{@answer.content}"
=======
    @answer.is_hidden = false
    @answer.save
    flash[:alert] = "你公开了回答#{@answer.content}"
    redirect_to :back
>>>>>>> xdite-refactor-0817
  end
end
