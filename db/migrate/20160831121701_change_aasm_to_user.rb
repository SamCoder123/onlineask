class ChangeAasmToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :aasm_state, from: "verification_applied", to: "unapplied"
  end
end
