class AddIsGuestToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_guest, :boolean, default: false
  end
end
