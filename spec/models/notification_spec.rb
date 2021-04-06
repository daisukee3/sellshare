# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :string           default(""), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :integer
#  tweet_id   :integer
#  visited_id :integer          not null
#  visitor_id :integer          not null
#
# Indexes
#
#  index_notifications_on_comment_id  (comment_id)
#  index_notifications_on_tweet_id    (tweet_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }
  let!(:comment) { create(:comment, tweet: tweet, user: other_user) }
  let!(:notification) { create(:notification, tweet: tweet, comment: comment, visitor: other_user, visited: user) }

  it 'notificationインスタンスが有効であること' do
    expect(notification).to be_valid
  end

  it 'visitor_idがnilの場合、無効であること' do
    notification.visitor_id = nil
    expect(notification).not_to be_valid
  end

  it 'visited_idがnilの場合、無効であること' do
    notification.visited_id = nil
    expect(notification).not_to be_valid
  end

end
