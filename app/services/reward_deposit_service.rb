class RewardDepositService
  def initialize(user, invitated_users, question)
    @user = user
    @question = question
    @invitated_users = invitated_users
  end

  def perform!
    # 问题提问成功后 扣除提问者的钱到超级管理员（平台）
    amount = @question.downpayment
    @user.deposit_money!(amount)
    @user.super_admin_bill!(amount)
    # 被邀请的人存入关系
    @question.invitation!(@invitated_users)
    @invitated_users.each do |user|
      NotificationService.new(user, current_user, @question).send_notification!
      OrderMailer.notify_invited_question(@question, user).deliver!
    end

    Bill.create!(amount: amount, question: @question, user: @user, flow: "in", detail: "提问押金")
  end
end
