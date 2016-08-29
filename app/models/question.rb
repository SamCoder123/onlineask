class Question < ApplicationRecord
  belongs_to :user
  has_many :tags
  has_many :answers
  has_many :question_invitations
  has_many :invitated_users, through: :question_invitations, source: :user
  has_many :bills

  validates :title, presence: true
  validates :description, presence: true
  validates :tag_list, presence: true

  validates :likes, presence: true, numericality:{greater_than:0}
  validates :downpayment, presence: true, numericality:{greater_than:0}


  # status 字段 有两种状态 open closed

  scope :published, -> { where(is_hidden: false) }

  acts_as_taggable_on :tags

  def updated_at_formate
    self.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end

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
    save
  end

  def reopen!
    self.status = "open"
    save
  end

  def invitation!(users)
    invitated_users << users
  end

  def cancel_invitation!(users)
    invitated_users.delete(users)
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
#  likes       :integer          default(0)
#
