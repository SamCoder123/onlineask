class AnswerSubscription < ApplicationRecord
  belongs_to :answer
  belongs_to :user
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
