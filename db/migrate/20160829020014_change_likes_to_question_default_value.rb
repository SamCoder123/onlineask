class ChangeLikesToQuestionDefaultValue < ActiveRecord::Migration[5.0]
  def up
    change_column :questions, :likes, :integer, default: 0
  end
end
