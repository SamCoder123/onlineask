class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string
    add_column :users, :is_admin, :boolean
    add_column :users, :description, :text
    add_column :users, :gender, :string
    add_column :users, :school, :string
    add_column :users, :major, :string
    add_column :users, :image, :string
  end
end
