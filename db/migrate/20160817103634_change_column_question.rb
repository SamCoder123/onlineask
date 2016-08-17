class ChangeColumnQuestion < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :is_hidden, :boolean, default:false
    change_column :answers, :is_hidden, :boolean, default:false

  end
end
