class Bill < ApplicationRecord
end

# == Schema Information
#
# Table name: bills
#
#  id          :integer          not null, primary key
#  question_id :integer
#  answer_id   :integer
#  user_id     :integer
#  flow        :string
#  detail      :string
#  amount      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
