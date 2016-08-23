class CreateAnswerSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_subscriptions do |t|
      t.integer :answer_id

      t.timestamps
    end
  end
end
