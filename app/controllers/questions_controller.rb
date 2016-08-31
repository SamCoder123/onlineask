class QuestionsController < ApplicationController
  before_action :set_question, only: %i(show edit update destroy)
  before_action :authenticate_user!, only: %i(create new edit update destroy question_like_up)
  before_action :validate_search_key, only: [:search]
  layout "user_center"

  def index
    @questions = Question.all
    drop_breadcrumb("所有问题")
    @questions = Question.published
    @questions = Question.published.last(3)

  end

  def show
    drop_breadcrumb("Home", root_path)
    drop_breadcrumb(@question.title)
  end

  def search
    if @query_string.present?
      # binding.pry
      search_result = Question.ransack(@search_criteria).result(distinct: true).includes(:answers)
      @questions = search_result.paginate(page: params[:page], per_page: 20)

      user_search_result = User.ransack(@user_search_criteria).result(distinct: true)
      @users = user_search_result.paginate(page: params[:page], per_page: 20)
      # set_page_title "搜寻 #{@query_string}"
    end
  end

  def question_like_up
    @question_like = Question.find(params[:id])
    @question_like.question_likes.create
    @user = current_user
    redirect_to :back
  end

  protected

  def validate_search_key
    @query_string = params[:query_string].gsub(/\\|\'|\/|\?/, "") if params[:query_string].present?
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
end
