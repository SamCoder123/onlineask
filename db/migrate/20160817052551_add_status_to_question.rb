class AddStatusToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:status,:string
  end
end
