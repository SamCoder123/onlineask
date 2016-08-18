class RewardDepositService
  def initialize(user)
    @user = user
  end

  def perform!
    # 问题保存成功后 扣除用户钱到超级管理员
    @user.deposit_money!(200)
  end
end
