class Account::UsersController < AccountController
  layout "user_center"

  def index_profile
    @user = current_user

    @followers = FollowRelationship.where(follower_id: @user)
    @followings = @user.followees
    @answer_subscriptions = @user.subscribing_answers
    @invitated_questions = @user.invitated_questions
    @questions = current_user.questions.published
    @answers = current_user.answers.published
    @best_answers = @answers.where(answer_status: "best_answer")

    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("个人资料")
  end

  # edit_profile，用来完善user的具体信息，user必须已经完成user_registration和new_user_session
  def new_profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("个人资料", index_profile_account_user_path(current_user))
    drop_breadcrumb("修改个人资料")

  end

  def update_profile
    @user = current_user
    if @user.update(params_user)
      redirect_to index_profile_account_user_path
    else
      render :edit_profile
    end
  end

  def show_profile
    @user = current_user
    drop_breadcrumb("首页")

    # 所有问题questions进行排序
    questions = case params[:order]
      when "by_question_created_at"
        Question.published.recent
      when "by_question_like_count"
        Question.published.sort_by{|question| question.question_likes.count}.reverse
      else
        Question.published
      end

    if current_user.tags.size.positive?
      tags = current_user.tag_list
      questions = questions.tagged_with(tags, :any => true)
    end
    @questions = questions.paginate(:page => params[:page], :per_page => 6)
    
  end

  def withdraw_edit
    @user = current_user
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("提现")
  end

  # withdraw_change显示取现后余额
  def withdraw_change
    @user = User.find(params[:id])
    cost = params[:user][:balance]

    if @user.balance >= cost.to_f
      @user.balance = @user.balance - cost.to_f
      @user.save
      redirect_to show_profile_account_user_path(@user)
    else
      flash[:alert] = "余额不足！"
      redirect_to :back
    end
  end

  # deposit_edit用户账户充值表单页面
  def deposit_edit
    @user = current_user
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("账户充值")
  end

  # deposit_change用户账户充值功能
  def deposit_change
    @user = User.find(params[:id])
    cost = params[:user][:balance]
    @user.balance = @user.balance + cost.to_f
    @user.save
    @user.phone_number = params[:user][:phone_number]
    @user.save
    options = { phone_number: @user.phone_number }
    SmsService.new(options).send_sms
    redirect_to show_profile_account_user_path(@user)
    flash[:notice] = "充值成功啦！"
  end

  # 链接到user展示页
  def exhibition_profile
    @user = User.find(params[:id])
    @blogs = @user.blogs
    @followers = FollowRelationship.where(follower_id: @user)
    @followings = @user.followees
    # @same_followees = current_user.followees.where(follower_id: @followings)
    @answers = @user.answers.paginate(page: params[:page], per_page: 5)
    @best_answers = @answers.where(answer_status: "best_answer")
    @answer_subscriptions = AnswerSubscription.where(answer_id: @answers)
    render layout: "profile"
  end

  def method_name
  end

  def my_subscriptions
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我偷听的答案")
    @user = current_user
    @answer_subscriptions = AnswerSubscription.where(user_id: current_user).order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def my_questions_answers
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的问题和回答")
    @user = current_user
    @questions = @user.questions.published.paginate(page: params[:page], per_page: 10)
    @answers = @user.answers.published.paginate(page: params[:page], per_page: 10)
  end

  def wallet
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的钱包")
    @user = current_user
  end

  def replyers

    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("学霸广场")

    replyers = case params[:order]
      when "by_like_count"
        User.where(role: "replyer").sort_by{|replyer| FollowRelationship.where(follower_id: replyer).count }.reverse
      when "by_school"
        User.where(role: "replyer").order("school DESC")
      else
        User.where(role: "replyer")
      end
    @replyers = replyers.paginate(:page => params[:page], :per_page => 9)
  end

  def follow_show
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的关注")
    @user = current_user
    # followers 是关注我的人，followees 是我关注的人
    @followers = FollowRelationship.where(follower_id: @user).paginate(page: params[:page], per_page: 10)
    @followees = FollowRelationship.where(user_id: @user).paginate(page: params[:page], per_page: 10)
  end

  def submit_application
    @user = User.find(params[:id])
    @user.submit_application!
    redirect_to :back
  end

  def add_tags
    tag_list = params[:tag_list]
    if tag_list
      tag_list = tag_list.map{|k,v| "#{k}#{v}"}.join(',')
      current_user.tag_list = tag_list
      current_user.save
    end

    redirect_to replyers_guide_guides_path
    #redirect_to show_profile_account_user_path(current_user)
  end

  private

  def params_user
    params.require(:user).permit(:role, :description, :gender, :school, :major, :image, :name)
  end

end
