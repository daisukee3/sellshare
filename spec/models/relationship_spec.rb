# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_follower_id   (follower_id)
#  index_relationships_on_following_id  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { create(:relationship) }

  it '関係性が有効であること' do
    expect(relationship).to be_valid
  end

  it 'follower_idがnilの場合、関係性が無効であること' do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it 'following_idがnilの場合、関係性が無効であること' do
    relationship.following_id = nil
    expect(relationship).not_to be_valid
  end
end
