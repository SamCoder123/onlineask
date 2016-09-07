class InvitateAnswerService
  def initialize(user, invitated_users, question)
    @user = user
    @question = question
    @invitated_users = invitated_users
  end

  def perform!
    # 被邀请的人存入关系
    @question.invitation!(@invitated_users)

    # 给邀请人发信
    @invitated_users.each do |user|
      NotificationService.new(user, @user, @question).send_notification!
      OrderMailer.notify_invited_question(@question, user).deliver!
    end
  end
end
