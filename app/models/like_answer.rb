class LikeAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :answer




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
