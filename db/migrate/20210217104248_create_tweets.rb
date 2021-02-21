class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
