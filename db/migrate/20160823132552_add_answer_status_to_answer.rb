class AddAnswerStatusToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :answer_status, :string, default: "pending"
  end
end
