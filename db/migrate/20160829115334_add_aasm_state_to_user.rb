class AddAasmStateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :aasm_state, :string, default: "verification_applied"
    add_index :users, :aasm_state
  end
end
