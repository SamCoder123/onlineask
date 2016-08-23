class RewardDepositService

  def perform!(user,invitated_users,question,amount)
    # 问题提问成功后 扣除提问者的钱到超级管理员（平台）

    user.deposit_money!(amount)
    user.super_admin_bill!(amount)
    # 被邀请的人存入关系
    question.invitation!(invitated_users)
  end
  
end
