class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

<<<<<<< HEAD
  scope :published,-> {where(is_hidden:false)}

  def hide!
    self.is_hidden = true
    self.save
  end

  def publish!
    self.is_hidden = false
    self.save
  end
=======
  scope :published, -> { where(is_hidden: false) }
>>>>>>> xdite-refactor-0817
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
