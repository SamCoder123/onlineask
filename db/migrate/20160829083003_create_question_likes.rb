class CreateQuestionLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :question_likes do |t|
      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end
  end
end
