class AddUserIdToTweets < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweets, :user
  end
end
