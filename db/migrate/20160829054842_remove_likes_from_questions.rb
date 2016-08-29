class RemoveLikesFromQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :likes, :integer
  end
end
