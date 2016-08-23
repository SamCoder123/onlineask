class AddDefaultValueToQuestionStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :status, :string, default: "open"
  end
end
