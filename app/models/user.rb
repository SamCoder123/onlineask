class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers

  # validates :name, presence: true
  # validates :role, presence: true
  # validates :gender, presence: true
  # validates :school, presence: true

  scope :super_admin,->{find(1)}

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
end
