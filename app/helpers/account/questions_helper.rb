module Account::QuestionsHelper
  def account_question_status(status)
    question_status = {open:'开放',closed:'关闭'}
    question_status[status.to_sym]
  end

  def show_button_base_status(question,answer)
    content_tag(:div) do
      if question.status=="open"
        concat link_to('赏他', to_downpayment_account_question_path(@question,answer_id:answer.id),method: :post,class:"btn btn-xs btn-danger",data: { confirm: "确定要赏他么?" })
      end
    end
  end
end
