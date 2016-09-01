class Blog < ApplicationRecord
  belongs_to :user

  def created_at_formate
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end

# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
