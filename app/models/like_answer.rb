class LikeAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :answer, counter_cache: true
end

# == Schema Information
#
# Table name: like_answers
#
#  id          :integer          not null, primary key
#  answer_id   :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  like_answer :integer
#
# Indexes
#
#  index_like_answers_on_answer_id  (answer_id)
#  index_like_answers_on_user_id    (user_id)
#
