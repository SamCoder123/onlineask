class QuestionInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :question

  after_create :send_notification

  def send_notification
    NotificationService.new(user, question.user, question).send_notification!
    OrderMailer.notify_invited_question(question, user).deliver!
  end
end

# == Schema Information
#
# Table name: question_invitations
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
