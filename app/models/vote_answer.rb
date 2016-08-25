class VoteAnswer < ApplicationRecord
end

# == Schema Information
#
# Table name: vote_answers
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
