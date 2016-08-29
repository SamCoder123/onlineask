class RewardAnswerSubscription
  def initialize(user, answer_owner, question_owner, answer)
    @user = user
    @answer_owner = answer_owner
    @question_owner = question_owner
    @answer = answer
  end

  def perform!
    amount = 20
    @question = @answer.question
    @user.deposit_money!(amount)
    @answer_owner.answer_owner_reward!(amount / 2)
    @question_owner.question_owner_reward!(amount / 2)
    Bill.create!(amount: amount, answer: @answer, question: @question, user: @user, flow: "in", detail: "偷听收费")
    Bill.create!(amount: amount / 2, answer: @answer, question: @question, user: @answer_owner, flow: "out", detail: "偷听to答主")
    Bill.create!(amount: amount / 2, answer: @answer, question: @question, user: @question_owner, flow: "out", detail: "偷听to题主")
  end
end
