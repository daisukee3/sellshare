# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  age          :integer
#  gender       :integer
#  introduction :text
#  type         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  let!(:user) { create(:user) }

  context '自己紹介が301文字の場合' do
    let!(:profile) { build(:profile, introduction: Faker::Lorem.characters(number: 301), user: user) }

    before do
      profile.save
    end

    it 'profileを保存できない' do
      expect(profile.errors.messages[:introduction][0]).to eq('は300文字以内で入力してください')
    end
  end
end
