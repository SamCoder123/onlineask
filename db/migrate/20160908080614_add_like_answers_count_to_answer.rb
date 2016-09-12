class AddLikeAnswersCountToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :like_answers_count, :integer
  end
end
