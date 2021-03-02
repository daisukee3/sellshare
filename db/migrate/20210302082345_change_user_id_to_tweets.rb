class ChangeUserIdToTweets < ActiveRecord::Migration[6.0]
  def self.up
    change_column_null :comments, :user_id, false, 0
  end

  def self.down
    change_column_null :comments, :user_id, true, nil
  end
end
