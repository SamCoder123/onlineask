class QuestionCancelService
  def initialize(question,current_user)
    @question  = question
    @amount = question.downpayment
    @user = current_user
  end

  def question_cancel!
    @question.close!
    @user.balance += @amount
    @user.save
  end

  def question_reopen!
    @question.reopen!
    @user.balance -= @amount
    @user.save
  end
end
