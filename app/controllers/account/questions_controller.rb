class Account::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,only:[:create,:new,:edit,:update,:destory]

  # GET /questions
  # GET /questions.json
  def index
    @questions = current_user.questions
  end

  # GET
  # GET
  def show
    @answers = @question.answers
  end

  # GET
  def new
    @question = Question.new
  end

  # GET
  def edit
  end

  # POST
  # POST
  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to account_questions_path, notice: '提问成功！'
    else
      render :new
    end
  end

  # PATCH/PUT
  # PATCH/PUT
  def update
    if @question.update(question_params)
      redirect_to account_questions_path, notice: '提问修改成功！'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to account_questions_path, notice: '提问成功删除！'
  end

  #赏他  分钱给平台和回答者
  def to_downpayment
    #接收参数并查询
    @question = Question.find(params[:id])
    @answer = Answer.find(params[:answer_id])

    #关闭问题
    @question.status = "closed"

    #分钱

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
