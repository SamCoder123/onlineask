class AddPaymentMethodToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :payment_method, :string
    add_column :questions, :is_paid, :boolean, default: false
  end
end
