class AddPaymentMethodToAnswerSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :answer_subscriptions, :payment_method, :string
  end
end
