class Tag < ApplicationRecord
  has_many :taggings
  has_many :questions,through: :taggings, source: :question
  
  validates :name, uniqueness: true
end

# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  taggings_count :integer          default(0)
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
