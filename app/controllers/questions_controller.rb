class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.status = 'open'

    Question.transaction do
      User.transaction do
        if @question.save
          # 保存用户 从平台扣钱150转给回答者
          save_user
          flash[:notice] = '提问成功！'
          redirect_to root_path
        else
          render :new
        end
      end
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = '提问修改成功！'
      redirect_to questions_path
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:title, :description, :downpayment)
  end

  def save_user
    # 问题保存成功后 扣除用户钱到超级管理员
    current_user.balance -= 200
    current_user.save

    super_admin = User.super_admin
    # binding.pry
    super_admin.balance += 200
    super_admin.save
  end
end
