class NotificationService
  # recipient 接收者
  # actor 发起者
  # notifiable  哪张表发起的  比如，question要提醒用户，这里就传question
  def initialize(recipient, actor, notifiable)
    @recipient = recipient
    @actor = actor
    @notifiable = notifiable
  end

  # 发送信息
  def send_notification!
    Notification.create(recipient: @recipient, actor: @actor, action: "notify_message", notifiable: @notifiable)
  end

  # 发送信息
  def send_notification_to_answer_owner!
    Notification.create(recipient: @recipient, actor: @actor, action: "notify_message_to_answer_owner", notifiable: @notifiable)
  end

  def send_notification_to_approved_user!
    Notification.create(recipient: @recipient, actor: @actor, action: "notify_message_to_approved_user", notifiable: @notifiable)
  end
end
