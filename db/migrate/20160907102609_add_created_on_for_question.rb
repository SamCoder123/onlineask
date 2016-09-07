class AddCreatedOnForQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :created_on, :datetime
    add_column :questions, :updated_on, :datetime
  end
end
