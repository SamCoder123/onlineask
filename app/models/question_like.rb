class QuestionLike < ApplicationRecord
  belongs_to :question
  belongs_to :user
end

# == Schema Information
#
# Table name: question_likes
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
