class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_breadcrumbs
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, :unless => :devise_controller?

  helper_method :guest_user?, :current_or_guest_user
  # 定义全局变量@hot_questions
  helper_method :hot_questions
  # 定义全局变量@hot_replyers
  helper_method :hot_replyers

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

  def hot_questions
    @hot_questions = Question.order("watches DESC").limit(6)
  end

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

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && (session[:guest_user_id] != current_user.id)
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.for(:sign_in) << :name
    # devise_parameter_sanitizer.for(:account_update) << :name
  end

  def guest_user?
    current_user && current_user.guest?
  end

  def authenticate_no_user_or_guest!
      redirect_to root_url if current_user.nil? && guest_user?
  end

  private

  def store_current_location
    if request.url == root_url
      store_location_for(:user, show_profile_account_users_url)
    end
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
      # comment.user_id = current_user.id
      # comment.save!
    # end
    # guest_user.move_to(current_user)
  end

  def create_guest_user
    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com", :is_guest => true)
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
