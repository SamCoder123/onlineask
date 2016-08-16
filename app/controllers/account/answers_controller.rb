class Account::AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = Answer.all
  end

  def show
  end

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  def edit
  end

  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      redirect_to account_answers_path, notice: '回答已发送！'
    else
      render :new
    end

  end

  def update
    if @answer.update(answer_params)
      redirect_to account_answers_path, notice: '回答已更新！'
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to account_answers_path, notice: '回答已删除！'
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
