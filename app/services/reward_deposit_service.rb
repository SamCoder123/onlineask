class RewardDepositService
  def initialize(user)
    @user = user
  end

  def perform!
    # 问题提问成功后 扣除提问者的钱到超级管理员（平台）
    @user.deposit_money!(200)
   end
 end
