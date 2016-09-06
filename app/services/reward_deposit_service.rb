class RewardDepositService
  def initialize(user, question)
    @user = user
    @question = question
  end

  def perform!
    # 问题提问成功后 扣除提问者的钱到超级管理员（平台）
    amount = @question.downpayment
    @user.deposit_money!(amount)
    @user.super_admin_bill!(amount)

    Bill.create!(amount: amount, question: @question, user: @user, flow: "in", detail: "提问押金")
  end
end
