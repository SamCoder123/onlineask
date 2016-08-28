class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  after_create :add_original_balance
  has_many :questions
  has_many :answers
  has_many :follow_relationships
  has_many :followees, through: :follow_relationships, source: :follow_relationship
  has_many :like_answers
  has_many :a_likes, through: :like_answers, source: :answer
  has_many :unlike_answers
  has_many :a_unlikes, through: :unlike_answers, source: :answer
  has_many :bills

  scope :super_admin, -> { find(1) }

  def add_original_balance
    amount = 1000
    self.balance += amount
    save
    Bill.create!(flow: "out", detail: "注册奖励", amount: amount, user_id: self.id)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :image, ImageUploader

  has_many :questions
  has_many :answers
  has_many :question_invitations
  has_many :invitated_questions, through: :question_invitations, source: :question

  has_many :answer_subscriptions
  has_many :subscribing_answers, through: :answer_subscriptions, source: :answer
  # validates :name, presence: true
  # validates :role, presence: true
  # validates :gender, presence: true
  # validates :school, presence: true

  scope :super_admin, -> { find(1) }

  def change_to_admin!
    self.is_admin = true
    save
  end

  def change_to_user!
    self.is_admin = false
    save
  end

  def admin?
    is_admin
  end

  def deposit_money!(amount)
    self.balance -= amount
    save
  end

  # 给答主钱
  def answer_owner_reward!(amount)
    self.balance += amount
    save
  end

  # 给问题主人钱
  def question_owner_reward!(amount)
    self.balance += amount
    save
  end

  # 给管理员钱
  def super_admin_bill!(amount)
    super_admin = User.super_admin
    super_admin.balance += amount
    super_admin.save
  end

  # 是否已经偷听问题
  def has_subscribed_answer?(answer)
    subscribing_answers.include?(answer)
  end

  # 偷听问题，把问题加入偷听列表
  def subscribe!(answer)
    subscribing_answers << answer
  end

  def already_follower?(followee)
    followees.include?(followee)
  end

  def follow!(followee)
    followees << followee
  end

  def stop_follow!(followee)
    followees.delete(followee)
  end

  def invitation!(question)
    invitated_questions << question
  end

  # 对回答点赞或踩
  def already_like?(answer)
    a_likes.include?(answer)
  end

  def like!(answer)
    a_likes << answer
  end

  def like_cancel!(answer)
    a_likes.delete(answer)
  end

  def already_unlike?(answer)
    a_unlikes.include?(answer)
  end

  def unlike!(answer)
    a_unlikes << answer
  end

  def unlike_cancel!(answer)
    a_unlikes.delete(answer)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#  is_admin               :boolean          default(FALSE)
#  description            :text
#  gender                 :string
#  school                 :string
#  major                  :string
#  image                  :string
#  name                   :string
#  balance                :float            default(0.0)
#  phone_number           :string
#  introduction           :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
