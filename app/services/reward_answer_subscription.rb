class RewardAnswerSubscription
  def initialize(user, answer_owner, question_owner)
    @user = user
    @answer_owner = answer_owner
    @question_owner = question_owner
  end

  def perform!
    amount = 20
    @user.deposit_money!(amount)
    @answer_owner.answer_owner_reward!(amount/2)
    @question_owner.question_owner_reward!(amount/2)
  end
 end
