class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  #status 字段 有两种状态 open closed

  scope :published,-> {where(is_hidden:false)}
end
