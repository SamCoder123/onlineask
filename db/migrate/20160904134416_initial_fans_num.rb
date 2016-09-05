class InitialFansNum < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :fans_num, :integer, default: 0
  end
end
