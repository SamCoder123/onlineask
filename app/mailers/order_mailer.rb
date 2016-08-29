class OrderMailer < ApplicationMailer
  def notify_invited_question(question, user)
    @question = question
    @user = user

    mail(to: user.email, subject: "[OnlineAsk] 您有一个回答邀请，悬赏￥#{@question.downpayment}元")
  end
end
