class Account::QuestionsController < ApplicationController
  before_action :set_question, only: %i(show edit update destroy)
  before_action :authenticate_user!

  # GET /questions
  # GET /questions.json
  def index
    @questions = current_user.questions.published
    drop_breadcrumb("我问过的问题")
  end

  # GET
  # GET
  def show
    @answers = @question.answers
    @invitated_users = @question.invitated_users
    drop_breadcrumb("我问过的问题", account_questions_path(@question))
    drop_breadcrumb(@question.title)

  end

  # GET
  def edit
    drop_breadcrumb("我问过的问题", account_questions_path(@question))
    drop_breadcrumb("编辑问题")
  end

  # PATCH/PUT
  # PATCH/PUT
  def update
    if @question.update(question_params)
      redirect_to account_questions_path, notice: "提问修改成功！"
    else
      render :edit
    end
  end

  def publish_hidden
    @question = Question.find(params[:id])
    is_hidden = params[:is_hidden]

    @question.is_hidden =
      if is_hidden == "publish"
        false
      else
        true
      end

    if @question.save
      flash[:notice] = "操作成功！"
    else
      flash[:alert] = "操作失败！"
    end

    redirect_to :back
  end

  # 赏他  分钱给平台和回答者
  def to_downpayment
    # 接收参数并查询
    @question = Question.find(params[:id])
    @answer = Answer.find(params[:answer_id])

    if @question.status != "closed"
      # 关闭问题
      # Question.transaction do
      # User.transaction do  加事务的，之后再考虑
      # 赏钱
      RewardBestAnswer.new(@answer, @question).perform!

      flash[:notice] = "已经向#{@answer.user.name}悬赏成功！"
    else
      flash[:alert] = "此问题已经关闭！"
    end

    redirect_to :back
  end

  def invitated_questions
    @invitated_questions = current_user.invitated_questions
  end

  # 把question的status改为close,并退款
  def cancel
    @question = Question.find(params[:id])
    if @question.answers.count == 0
      @question.close!
      current_user.balance += 200
      current_user.save
      flash[:notice] = "Your question has been cancelled. Please check your account."
    else
      flash[:alert] = "Sorry, you can't cancel this question as it has already been answered."
    end
    redirect_to :back
  end

  # 把question的status改为open,并扣款
  def reopen
    @question = Question.find(params[:id])
    @question.reopen!
    current_user.balance -= 200
    current_user.save
    flash[:notice] = "Your question has been re-opened."
    redirect_to :back
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:title, :tag_list, :description)
  end

end
