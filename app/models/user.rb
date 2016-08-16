class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
