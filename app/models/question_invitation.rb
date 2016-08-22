class QuestionInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :question
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
