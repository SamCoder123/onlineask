class Account::AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @answers = current_user.answers.published
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

  # def destroy
  #   @answer.destroy
  #   redirect_to account_answers_path, notice: '回答已删除！'
  # end
  def publish_hidden
    @answer = Answer.find(params[:id])
    is_hidden = params[:is_hidden]

    if is_hidden=="publish"
      @answer.is_hidden = false
    else
      @answer.is_hidden = true
    end

    if @answer.save
      flash[:notice] = "操作成功！"
    else
      flash[:alert] = "操作失败！"
    end

    redirect_to :back
  end

  def subscribe_answers
    @answer = Answer.find(params[:id])
    if @answer.user == current_user
      flash[:alert] = "不能偷听自己的回答！"
      return
    end
    if current_user.has_subscribed_answer?(@answer)
      flash[:alert] = "您已经购买过答案，可以直接偷听"
      redirect_to my_subscriptions_account_user_path(current_user)
      return
    end
    if current_user.subscribe!(@answer)
      RewardAnswerSubscription.new(current_user, @answer.user, @answer.question.user).perform!
      flash[:notice] = "可以偷听答案了！"
    else
      flash[:alert] = "偷听不成功"
    end
    redirect_to :back
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
