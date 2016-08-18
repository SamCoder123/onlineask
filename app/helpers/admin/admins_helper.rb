module Admin::AdminsHelper
  def render_admin_questions_bill_total(questions)
    sum = 0
    questions.each do |question|
      sum += question.downpayment
    end
    sum
  end

  def render_admin_questions_income_total(questions)
    each_question_income = 50
    sum = questions.count * each_question_income
    sum
  end

  def controller?(controller)
    controller.include?(params[:controller])
  end

  def action?(action)
    action.include?(params[:action])
  end
end
