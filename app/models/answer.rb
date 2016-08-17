class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  scope :published,-> {where(is_hidden:false)}

end
