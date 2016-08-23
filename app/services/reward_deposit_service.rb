class RewardDepositService
  def initialize(user,invitated_users,question)
    @user = user
    @question = question
    @invitated_users = invitated_users
  end

  def perform!
    # 问题提问成功后 扣除提问者的钱到超级管理员（平台）
    @user.deposit_money!(200)

    # 被邀请的人存入关系
    #@invitated_user.invitation!(@question)
    @question.invitation!(@invitated_users)

   end
 end
