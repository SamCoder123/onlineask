class Account::UsersController < ApplicationController
  before_action :authenticate_user!

  layout "user_center"

  def index_profile
    @user = current_user
    @questions = current_user.questions.published
    @answers = current_user.answers.published
    @answer_subscriptions = AnswerSubscription.where(answer_id: @answers)
    drop_breadcrumb("个人主页")
  end
  # edit_profile，用来完善user的具体信息，user必须已经完成user_registration和new_user_session
  def new_profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
    drop_breadcrumb("用户信息", show_profile_account_user_path(@user))
    drop_breadcrumb("修改信息")
  end

  def update_profile
    @user = current_user
    if @user.update(params_user)
      redirect_to show_profile_account_user_path(@user)
    else
      render :edit_profile
    end
  end

  def show_profile
    @user = current_user
    drop_breadcrumb("用户信息")
    @questions = Question.all
  end

  def withdraw_edit
    @user = current_user
    drop_breadcrumb("用户信息", show_profile_account_user_path(@user))
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
    drop_breadcrumb("用户信息", show_profile_account_user_path(@user))
    drop_breadcrumb("充值")
  end

  # deposit_change用户账户充值功能
  def deposit_change
    @user = User.find(params[:id])
    cost = params[:user][:balance]
    @user.balance = @user.balance + cost.to_f
    @user.save
    @user.phone_number = params[:user][:phone_number]
    @user.save
    options = {phone_number: @user.phone_number}
    SmsService.new(options).send_sms
    redirect_to show_profile_account_user_path(@user)
    flash[:notice] = "充值成功啦！"
  end

  # 链接到user展示页
  def exhibition_profile
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to index_profile_account_user_path(current_user)
      return
    end
    @followers = FollowRelationship.where(user_id: @user)
    @followings = FollowRelationship.where(follower_id: @user)
    @answers = @user.answers
    @best_answers = @answers.where(answer_status: "best_answer")
    @answer_subscriptions = AnswerSubscription.where(answer_id: @answers)
    render layout: "profile"
  end

  def my_subscriptions
    drop_breadcrumb("我偷听的答案")
    @user = current_user
    @answers = current_user.subscribed_answers.paginate(page: params[:page], per_page: 5)
  end

  private

  def params_user
    params.require(:user).permit(:role, :description, :gender, :school, :major, :image, :name)
  end
end
