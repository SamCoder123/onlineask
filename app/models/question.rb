class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  #status 字段 有两种状态 open closed

  scope :published,-> {where(is_hidden:false)}
end

# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  vote        :integer
#  is_hidden   :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  downpayment :float            default(0.0)
#  status      :string
#
