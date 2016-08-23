module Account::QuestionsHelper
  def account_question_status(status)
    question_status = { open: "开放", closed: "关闭" }
    question_status[status.to_sym]
  end

  def show_button_base_status(question, answer)
    content_tag(:div) do
      if question.status == "open"
        concat link_to("赏他", to_downpayment_account_question_path(@question, answer_id: answer.id), method: :post, class: "btn btn-xs btn-danger", data: { confirm: "确定要赏他么?" })
      end
    end
  end

  def render_cancel_reopen(question)
    if question.status == "closed"
      link_to("重开", reopen_account_question_path(question), method: :post)
    elsif question.status == "open"
      link_to("取消提问并退款", cancel_account_question_path(question), method: :post, data: { confirm: "Are you sure you want to cancel the question?" })
    end
  end
end
