class Account::QuestionsController < AccountController
  before_action :set_question, only: %i(show edit update destroy)

  def index
    @questions = current_user.questions.published
    drop_breadcrumb("个人首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我问过的问题")
    @questions = @questions.paginate(page: params[:page], per_page: 10)
    render layout: "user_center"
  end

  def show
    @answers = @question.answers.order("answer_status")
    @invitated_users = @question.invitated_users
    drop_breadcrumb("个人首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("我问过的问题", account_questions_path(@question))
    drop_breadcrumb(@question.title)
  end

  def edit
    @invitated_users = @question.invitated_users
    @filters_arry = []
    for user in @invitated_users
      @filters_arry << user.id
    end
    @filters = @filters_arry.map(&:inspect).join(",")
    @users = User.all - @invitated_users
    drop_breadcrumb("我问过的问题", account_questions_path(@question))
    drop_breadcrumb("编辑问题")
  end

  def update
    if @question.update(question_params)
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

      redirect_to account_questions_path, notice: "提问修改成功！"
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

      NotificationService.new(@answer.user, current_user, @answer).send_notification_to_answer_owner!

      flash[:notice] = "已经向#{@answer.user.name}悬赏成功！"
    else
      flash[:alert] = "此问题已经关闭！"
    end

    redirect_to :back
  end

  def invitated_questions
    @invitated_questions = current_user.invitated_questions
    drop_breadcrumb("个人首页", show_profile_account_user_path(current_user))
    drop_breadcrumb("被邀请的问题")
    render layout: "user_center"
  end

  # 把question的status改为close,并退款
  def cancel
    @question = Question.find(params[:id])
    if @question.answers.count.zero?
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
