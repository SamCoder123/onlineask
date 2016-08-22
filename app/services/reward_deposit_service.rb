class RewardDepositService
  def initialize(user)
    @user = user
  end

  def perform!
    # 问题提问成功后 扣除提问者的钱到超级管理员（平台）
    amount = 200
    # binding.pry
    @user.deposit_money!(amount)
    @user.super_admin_bill!(amount)
    # binding.pry
   end
 end
