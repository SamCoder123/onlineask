class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_breadcrumbs
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, :unless => :devise_controller?

  def require_is_admin
    unless current_user.admin?
      flash[:alert] = "你没有管理员权限"
      redirect_to questions_path
    end
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  def drop_breadcrumb(title = nil, url = nil)
    title ||= @page_title

    if title && url
      @breadcrumbs.push(view_context.link_to(title, url))
    elsif title
      @breadcrumbs.push(title)
    end
  end

  # 定义全局变量@hot_questions
  helper_method :hot_questions

  def hot_questions
    @hot_questions = Question.order("watches DESC").limit(6)
  end

  # 定义全局变量@hot_replyers
  helper_method :hot_replyers

  def hot_replyers
    @hot_replyers = User.order("fans_num DESC").limit(6)
  end

  def set_page_title_and_description(title, description)
    unless title.blank?
      set_page_title title
    end
    unless description.blank?
      set_page_description description
    end
  end

  def exhibition_profile_data
    @followers = FollowRelationship.where(follower_id: @user)
    @followings = @user.followees
    # @same_followees = current_user.followees.where(follower_id: @followings)
    @answers = @user.answers.paginate(page: params[:page], per_page: 5)
    @questions = @user.questions.paginate(page: params[:page], per_page: 5)
    @best_answers = @answers.where(answer_status: "best_answer")
    @answer_subscriptions = @user.subscribing_answers.order("id DESC").paginate(page: params[:page], per_page: 5)
    @invitated_questions = @user.invitated_questions.paginate(page: params[:page], per_page: 5)

    render layout: "profile"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def store_current_location
    if request.url == root_url
      store_location_for(:user, show_profile_account_users_url)
    end
  end

end
