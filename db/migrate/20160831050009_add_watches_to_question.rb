class AddWatchesToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :watches, :integer, default: 0
  end
end
