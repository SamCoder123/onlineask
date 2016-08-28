class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.integer :question_id
      t.integer :answer_id
      t.integer :user_id
      t.string :flow
      t.string :detail
      t.float :amount

      t.timestamps
    end
  end
end
