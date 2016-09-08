module QuestionsHelper
  def render_highlight_content(question, query_string)
    excerpt_cont = excerpt(question.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end

  def render_question_closed?(question)
    if question.status == "open"
      content_tag(:span, "悬赏金额 ¥ #{question.downpayment}", class:"media-meta pull-left", style: "padding-right:20px")
    else
      label_tag "已悬赏"
    end
  end

end
