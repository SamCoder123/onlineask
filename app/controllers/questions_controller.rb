class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_filter :validate_search_key, only: [:search]

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

    if @question.save

      # 保存用户 从平台扣钱150转给回答者
      RewardDepositService.new(current_user).perform!

      flash[:notice] = '提问成功！'
      redirect_to root_path
    else
      render :new
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

  def search
    if @query_string.present?
      #binding.pry
      search_result = Question.ransack(@search_criteria).result(distinct: true).includes(:answers)
      @questions = search_result.paginate(page: params[:page], per_page:2)

      user_search_result = User.ransack(@user_search_criteria).result(distinct: true)
      @users = user_search_result.paginate(page: params[:page], per_page:2)
      #set_page_title "搜寻 #{@query_string}"
    end
  end

  protected

  def validate_search_key
    @query_string = params[:query_string].gsub(/\\|\'|\/|\?/, '') if params[:query_string].present?
    @search_criteria = search_criteria(@query_string)
    @user_search_criteria = user_search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { title_or_description_or_answers_content_cont: query_string }
  end

  def user_search_criteria(query_string)
    { email_or_name_cont: query_string }
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
end
