module Account::QuestionsHelper
  def account_question_status(status)
    question_status = {open:'开放',closed:'关闭'}
    unless status.nil?
      question_status[status.to_sym]
    end
  end

  def render_cancel_reopen(question)
    if question.status == "closed"
      link_to("重开", reopen_account_question_path(question), method: :post,class:"btn btn-default btn-xs")
    elsif question.status == "open"
      link_to("取消提问并退款", cancel_account_question_path(question), method: :post,class:"btn btn-default btn-xs", data: { confirm: "Are you sure you want to cancel the question?" })
    end
  end
end
