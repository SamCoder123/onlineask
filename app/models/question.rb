class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  # status 字段 有两种状态 open closed

  attr_accessible :tag_list
  acts_as_taggable_on

  scope :published, -> { where(is_hidden:false) }

  def hide!
    self.is_hidden = true
    self.save
  end

  def publish!
    self.is_hidden = false
    self.save
  end

  def close!
      self.status = "closed"
      self.save
  end

  def reopen!
      self.status = "open"
      self.save
  end
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
