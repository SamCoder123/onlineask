class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def admin?
    true
  end

  def change_to_admin!
    self.is_admin = true
    self.save

  end

  def change_to_user!
    self.is_admin = false
    self.save

  end

  # validates :name, presence: true
  # validates :role, presence: true
  # validates :gender, presence: true
  # validates :school, presence: true

  has_many :questions
  has_many :answers

  def admin?
    is_admin
  end
end
