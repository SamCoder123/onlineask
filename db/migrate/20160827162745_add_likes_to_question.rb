class AddLikesToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :likes, :integer
  end
end
