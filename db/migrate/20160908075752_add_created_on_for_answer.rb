class AddCreatedOnForAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :created_on, :date
    add_column :answers, :updated_on, :date
  end
end
