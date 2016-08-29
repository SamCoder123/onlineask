class AddLikesToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :likes, :integer, default: 0
  end
end
