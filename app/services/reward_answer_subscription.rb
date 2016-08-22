class RewardAnswerSubscription
  def initialize(user)
    @user = user
  end

  def perform!
    amount = 20
    @user.deposit_money!(amount)
  end
 end
