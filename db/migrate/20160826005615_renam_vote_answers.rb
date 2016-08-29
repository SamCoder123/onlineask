class RenamVoteAnswers < ActiveRecord::Migration[5.0]
  def change
    rename_table :vote_answers, :like_answers
    remove_column :like_answers, :unlike_answer
  end
end
