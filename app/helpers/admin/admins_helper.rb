module Admin::AdminsHelper
  def render_admin_questions_bill_total(questions)
    sum = 0
    questions.each do |question|
      sum += question.downpayment
    end
    return sum
  end

  def render_admin_questions_income_total(questions)
    each_question_income = 50
    sum = questions.count * each_question_income
    return sum
  end
end
