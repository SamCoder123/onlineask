class RewardBestAnswer
  def initialize(user, question)
    @user = user
    @question = question
  end

  def perform!
    # 赞赏之后，admin支出150，答主得到150
    original_amount = 200
    service_fee = 50
    @user.super_admin_bill!(service_fee - original_amount)
    @user.answer_owner_reward!(original_amount - service_fee)

    # 更改问题状态
    @question.status = "closed"
    @question.save
   end
 end
