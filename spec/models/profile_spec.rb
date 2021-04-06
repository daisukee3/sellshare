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
