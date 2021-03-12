class ChangeContentToTweets < ActiveRecord::Migration[6.0]
  def self.up
    change_column_null :tweets, :content, false, 0
  end

  def self.down
    change_column_null :tweets, :content, true, nil
  end
end
