class OrderMailer < ApplicationMailer
 def notify_invited_question(question)
   @question = question
   @users = @question.invitated_users

   @users.each do |user|
     mail(to: user.email, subject:"[OnlineAsk] 您有一个回答邀请，悬赏￥#{@question.downpayment}元")
   end
 end
end
