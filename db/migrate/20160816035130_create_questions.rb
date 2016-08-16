class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :vote
      t.boolean :is_hidden
      t.integer :user_id

      t.timestamps
    end
  end
end
