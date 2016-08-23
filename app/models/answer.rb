class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  has_many :answer_subscription
  has_many :subscribed_users, through: :answer_subscriptions, source: :user

  scope :published, -> { where(is_hidden: false) }

  def hide!
    self.is_hidden = true
    save
  end

  def publish!
    self.is_hidden = false
    save
  end
end

# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  is_hidden   :boolean          default(FALSE)
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
