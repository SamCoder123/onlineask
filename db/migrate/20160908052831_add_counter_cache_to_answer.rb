class AddCounterCacheToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :answer_subscriptions_count, :integer
  end
end
