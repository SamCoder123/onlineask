class ChangeIndexAasmStateToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :aasm_state if index_exists?(:users, :aasm_state)
    add_index :users, :aasm_state, length: 20
  end
end
