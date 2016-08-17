class Account::UsersController < ApplicationController
  before_action :authenticate_user!

# edit_profile，用来完善user的具体信息，user必须已经完成user_registration和new_user_session
  def new_profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
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
  end

  def withdraw_edit
    @user = current_user
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

  private


  def params_user
    params.require(:user).permit(:role,:description,:gender,:school,:major,:image,:name)
  end


end
