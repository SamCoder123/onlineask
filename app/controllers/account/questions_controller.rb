class Account::QuestionsController < AccountController
  before_action :set_question, only: %i(show edit update destroy refine_reward)
  layout "user_center"

  def index
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("问题")

    # 所有问题questions进行排序
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
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的问题和回答",my_questions_answers_account_user_path)
    drop_breadcrumb(@question.title)

    @answers = @question.answers.order("answer_status")
    @refer_questions = Question.published.where(status: "open").order("watches DESC").limit(3)
    @invitated_users = @question.invitated_users
    @filters_arry = @invitated_users.collect(&:id)
    @filters = @filters_arry.map(&:inspect).join(",")
    @users = User.where.not(id:current_user)

  end

  def refine_reward
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的问题和回答",my_questions_answers_account_user_path)
    drop_breadcrumb(@question.title)

    update_invitated_users_and_notify

    flash[:notice] = "调整成功，学霸正在赶来！"

    redirect_to account_question_path(@question)
  end

  def new
    @users = User.where.not(id:current_user)
    #binding.pry
    @tags = Tag.all
    @question = Question.new
    drop_breadcrumb("Home", root_path)
    drop_breadcrumb("我要提问")
  end

  def create
    unless params[:question][:tag_list]
      flash[:alert] = "标签不能为空"
      redirect_to :back
      return
    end

    @question = Question.new(question_params)
    @question.user = current_user
    @question.status = "open"

    if @question.save

      # 保存用户 从平台扣钱150转给回答者
      RewardDepositService.new(current_user, @question).perform!

      # 把邀请人和问题存入关系表
      unless @invitated_users.nil?
        @invitated_users = User.where(id: params[:filters].split(","))

        InvitateAnswerService.new(current_user, @invitated_users, @question).perform!
      end

      flash[:notice] = "提问成功！"
      redirect_to account_question_path (@question)
    else
      @users = User.all
      @tags = Tag.all
      render :new
    end
  end

  def edit
    @invitated_users = @question.invitated_users
    @filters_arry = @invitated_users.collect(&:id)
    @filters = @filters_arry.map(&:inspect).join(",")
    @users = User.where.not(id:current_user)
    @tags = Tag.all - @question.tags
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我的问题和回答",my_questions_answers_account_user_path)
    drop_breadcrumb("编辑问题")
  end

  def update
    unless params[:question][:tag_list]
      flash[:alert] = "标签不能为空"
      redirect_to :back
      return
    end
    if @question.update(question_params)

      update_invitated_users_and_notify

      redirect_to account_question_path(@question), notice: "提问修改成功！"
    else
      render :edit
    end
  end

  def publish_hidden
    @question = Question.find(params[:id])
    if @question.answers.count.positive?
      flash[:alert] = "亲，您的问题已被回答，不能删除了"
      redirect_to :back
      return
    end

    is_hidden = params[:is_hidden]

    @question.is_hidden =
      if is_hidden == "publish"
        false
      else
        true
      end

    if @question.save
      flash[:notice] = "您已删除问题！"
      redirect_to show_profile_account_user_path(current_user)
    else
      flash[:alert] = "操作失败！"
      redirect_to :back
    end
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

      NotificationService.new(@answer.user, current_user, @answer).send_notification_to_answer_owner!

      flash[:notice] = "已经向#{@answer.user.name}悬赏成功！"
    else
      flash[:alert] = "此问题已经关闭！"
    end

    redirect_to :back
  end

  def invitated_questions
    @invitated_questions = current_user.invitated_questions.paginate(:page => params[:page], :per_page => 6)
    drop_breadcrumb("首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("被邀请的问题")
    set_page_title_and_description("#{current_user.name}被邀请的问题","首页 被邀请的问题")

    render layout: "user_center"
  end

  # 把question的status改为close,并退款
  def cancel
    @question = Question.find(params[:id])
    if @question.answers.count.zero?
      QuestionCancelService.new(@question,current_user).question_cancel!
      flash[:notice] = "Your question has been cancelled. Please check your account."
    else
      flash[:alert] = "Sorry, you can't cancel this question as it has already been answered."
    end
    redirect_to :back
  end

  # 把question的status改为open,并扣款
  def reopen
    @question = Question.find(params[:id])
    QuestionCancelService.new(@question,current_user).question_reopen!
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
    # tag_list 这个gem接收name1,name2,name3这种字符串形式，所以在permit之前要解析成字符串
    unless params[:question][:tag_list].nil?
      params[:question][:tag_list] = params[:question][:tag_list].map{|k,v| "#{k}#{v}"}.join(',')
    end
    params.require(:question).permit(:title, :description, :tag_list, :downpayment, :payment_method)
  end

  def update_invitated_users_and_notify
    # 新的
    @new_invitated_users = User.where(id: params[:filters].split(","))

    # 旧的
    @old_invitated_users = @question.invitated_users

    # 并集
    union_users = @new_invitated_users | @old_invitated_users

    # 并集－旧的 ＝ 新增
    add_users = union_users - @old_invitated_users

    # 并集－新的 ＝ 删除的
    delete_users = union_users - @new_invitated_users

    # 新增邀请
    unless add_users.empty?
      @question.invitation!(add_users)
      # 如何一下给多个用户发送？循环新增是不是不好？
      for user in add_users
        NotificationService.new(user, current_user, @question).send_notification!
        OrderMailer.notify_invited_question(@question, user).deliver!
      end
    end

    # 取消邀请
    unless delete_users.empty?
      @question.cancel_invitation!(delete_users)
    end
  end
end
