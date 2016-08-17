class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  scope :published,-> {where(is_hidden:false)}

end

# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  is_hidden   :boolean
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
