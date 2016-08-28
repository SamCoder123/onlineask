class Bill < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer
end

# == Schema Information
#
# Table name: bills
#
#  id                     :integer          not null, primary key
#  question_id            :integer
#  answer_id              :integer
#  user_id                :integer
#  flow                   :string
#  detail                 :string
#  amount                 :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  answer_subscription_id :integer
#
