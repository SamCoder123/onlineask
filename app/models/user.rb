class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  after_create :add_original_balance
  has_many :questions
  has_many :answers
  has_many :follow_relationships
  has_many :followees, through: :follow_relationships, source: :follow_relationship

  scope :super_admin, -> { find(1) }

  def add_original_balance
    self.balance += 1000
    self.save
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :image, ImageUploader


  def change_to_admin!
    self.is_admin = true
    self.save
  end

  def change_to_user!
    self.is_admin = false
    self.save
  end

  def admin?
    is_admin
  end

  def deposit_money!(amount)
    self.balance -= amount
    save

    super_admin = User.super_admin
    super_admin.balance += amount
    super_admin.save
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
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
