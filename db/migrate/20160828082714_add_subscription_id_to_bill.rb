class AddSubscriptionIdToBill < ActiveRecord::Migration[5.0]
  def change
    add_column :bills, :answer_subscription_id, :integer
  end
end
