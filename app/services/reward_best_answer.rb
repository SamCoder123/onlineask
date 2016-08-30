class RewardBestAnswer
  def initialize(answer, question)
    @answer = answer
    @answer_owner = answer.user
    @question = question
  end

  # 赞赏之后，从admin这里扣除问题押金的80%转入最佳回答者
  # 服务费 赏金的20%
  # 最佳回答者获得 赏金的80%
  def perform!
    original_amount = @question.downpayment

    service_fee = original_amount * 0.2
    # 从问题赏金中扣除服务费
    @answer_owner.super_admin_bill!(service_fee - original_amount)
    # 向最佳回答者转入 赏金的80%
    @answer_owner.answer_owner_reward!(original_amount - service_fee)

    # 更新问题状态
    @question.status = "closed"
    @question.save

    # 更新answer的状态
    @answer.best_answer!
    @answer.make_others_unchosen!(@question)

    Bill.create!(amount: original_amount - service_fee, question: @question, answer: @answer, user: @answer_owner, flow: "out", detail: "最佳答案")
  end
end
