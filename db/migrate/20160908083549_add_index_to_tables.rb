class AddIndexToTables < ActiveRecord::Migration[5.0]
  def change
    add_index :answer_subscriptions, :user_id
    add_index :answer_subscriptions, :answer_id


    add_index :answers, :user_id
    add_index :answers, :question_id

    add_index :follow_relationships, :user_id
    add_index :follow_relationships, :follower_id

    add_index :images, :user_id

    add_index :like_answers, :answer_id
    add_index :like_answers, :user_id

    add_index :notifications, :recipient_id
    add_index :notifications, :actor_id
    add_index :notifications, :notifiable_id

    add_index :question_likes, :question_id
    add_index :question_likes, :user_id

    add_index :questions, :user_id

  end
end
