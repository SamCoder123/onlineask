class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i(create new edit update destroy)
  before_action :check_question_and_require_not_self_reply, only: %i(new edit create update)
  before_action :set_answer, only: %i(show edit update destroy)

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    drop_breadcrumb(@question.title, question_path(@question))
    drop_breadcrumb("我要回答")
    @question.watches_counter!
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question
    unless current_user.gender && current_user.school && current_user.major
      current_user.gender = params[:gender].downcase if params[:gender]
      current_user.school = params[:school] if params[:school]
      current_user.major = params[:major] if params[:major]
      current_user.save
    end

    if @answer.save
      NotificationService.new(@question.user, current_user, @answer).send_notification!
      redirect_to account_answer_path(@answer), notice: "回答已发送！"
    else
      render :new
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

  def check_question_and_require_not_self_reply
    @question = Question.find(params[:question_id])
    if @question.user == current_user
      flash[:warning] = "亲，不要回答自己的问题哦~"
      redirect_to :back
    end
  end

end
