class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :answer_subscriptions
  has_many :subscribed_users, through: :answer_subscriptions, source: :user
  has_many :like_answers
  # has_many :user_likes, through: :like_answers, source: :user
  has_many :unlike_answers

  # answer_status 字段 有3种状态 pending best_answer unchosen

  scope :published, -> { where(is_hidden: false) }

  def updated_at_formate
    updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def hide!
    self.is_hidden = true
    save
  end

  def publish!
    self.is_hidden = false
    save
  end

  def best_answer!
    self.answer_status = "best_answer"
    save
  end

  def make_others_unchosen!(question)
    question.answers.each do |answer|
      if answer.answer_status != "best_answer"
        answer.answer_status = "unchosen"
        answer.save
      end
    end
  end
end

# == Schema Information
#
# Table name: answers
#
#  id                         :integer          not null, primary key
#  content                    :text
#  is_hidden                  :boolean          default(FALSE)
#  user_id                    :integer
#  question_id                :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  answer_status              :string           default("pending")
#  created_on                 :date
#  updated_on                 :date
#  answer_subscriptions_count :integer
#  like_answers_count         :integer
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
