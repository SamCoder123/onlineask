class QuestionsController < ApplicationController
  before_action :set_question, only: %i(show edit update destroy)
  # before_action :authenticate_user!, only: %i(create new edit update destroy question_like_up show)
  before_action :validate_search_key, only: [:search]
  layout "public_pages",except: [:search]

  def index
    drop_breadcrumb("问题广场")
    set_page_title_and_description("问题广场", "问题列表 美国、欧洲、日本等众多留学问题")
    questions = case params[:order]
      when "by_question_created_on"
        Question.published.recent
      when "by_downpayment"
        Question.published.opening.order("downpayment DESC")
      when "by_question_like_count"
        Question.published.sort_by{|question| question.question_likes.count}.reverse
      else
        Question.published
      end

    @questions = questions.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    drop_breadcrumb("Home", root_path)
    drop_breadcrumb(@question.title)
    set_page_title_and_description("留学问题: #{@question.title}", "#{@question.description}")
    @question.watches_counter!
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

  def public_replyers
    drop_breadcrumb("Landing Page", root_path)
    drop_breadcrumb("学霸广场")
    set_page_title_and_description("学霸广场", "学霸广场 美国、欧洲、日本名校生解答申请问题")

    replyers =
      case params[:order]
      when "by_like_count"
        User.where(role: "replyer").sort_by { |replyer| FollowRelationship.where(follower_id: replyer).count }.reverse
      when "by_school"
        User.where(role: "replyer").order("school DESC")
      else
        User.where(role: "replyer")
           end
    @replyers = replyers.paginate(page: params[:page], per_page: 6)
  end

  def question_like_up
    @question_like = Question.find(params[:id])

    if !current_user.question_already_like?(@question_like)
      current_user.question_like!(@question_like)
      flash[:notice] = "想听该问题? 试试偷听功能～"
    else
      current_user.question_like_cancle!(@question_like)
    end
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
