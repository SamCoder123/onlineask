class AnswerSubscription < ApplicationRecord
  belongs_to :answer, counter_cache: true
  belongs_to :user
  has_many :bills
end

# == Schema Information
#
# Table name: answer_subscriptions
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_answer_subscriptions_on_answer_id  (answer_id)
#  index_answer_subscriptions_on_user_id    (user_id)
#
