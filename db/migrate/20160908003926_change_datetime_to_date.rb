class ChangeDatetimeToDate < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :created_on, :date
    change_column :questions, :updated_on, :date
  end
end
