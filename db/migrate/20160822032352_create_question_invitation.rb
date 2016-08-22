class CreateQuestionInvitation < ActiveRecord::Migration[5.0]
  def change
    create_table :question_invitations do |t|
      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end
  end
end
