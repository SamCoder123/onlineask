class AddCountsForTables < ActiveRecord::Migration[5.0]
  def change
    change_column :answers, :like_answers_count, :integer, default: 0
    add_column :users, :questions_count, :integer, default: 0
    add_column :users, :follow_relationships_count, :integer, default: 0
    add_column :users, :answers_count, :integer, default: 0
    add_column :questions, :answers_count, :integer, default: 0
  end
end
