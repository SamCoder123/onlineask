class AnswersController < ApplicationController
  before_action :set_answer, only: %i(show edit update destroy)
  before_action :authenticate_user!, only: %i(create new edit update destroy)

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    drop_breadcrumb("公共问题", questions_path(@question))
    drop_breadcrumb(@question.title)
    drop_breadcrumb("我要回答")
  end

  def edit
    @question = Question.find(params[:question_id])
  end

  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      NotificationService.new(@question.user,current_user,@answer).send_notification!
      redirect_to root_path, notice: "回答已发送！"
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to account_answers_path, notice: "回答已更新！"
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:content)
  end
end
