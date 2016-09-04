class AddFansToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fans_num, :integer  
  end
end
