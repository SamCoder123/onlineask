class AddLikeUnlikeColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :vote_answers, :like_answer, :integer
    add_column :vote_answers, :unlike_answer, :integer
  end
end
