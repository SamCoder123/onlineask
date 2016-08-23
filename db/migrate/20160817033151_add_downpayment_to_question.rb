class AddDownpaymentToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :downpayment, :float, default: 0
  end
end
