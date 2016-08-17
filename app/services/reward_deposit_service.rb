class RewardDepositService
  def initialize(user)
    @user = user
  end

  def perform!
    # 问题保存成功后 扣除用户钱到超级管理员
    @user.balance -= 200
    @user.save

    super_admin = User.super_admin
    # binding.pry
    super_admin.balance += 200
    super_admin.save
  end
end
