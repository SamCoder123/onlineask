class Question < ApplicationRecord
  belongs_to :user
  has_many :tags
  has_many :answers
  has_many :question_invitations
  has_many :invitated_users, through: :question_invitations, source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :tag_list, presence: true
  validates :downpayment, presence: true

  # status 字段 有两种状态 open closed

  scope :published, -> { where(is_hidden: false) }

  acts_as_taggable

  def hide!
    self.is_hidden = true
    save
  end

  def publish!
    self.is_hidden = false
    save
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
#  status      :string           default("open")
#  tag         :string
#
