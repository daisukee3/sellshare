# == Schema Information
#
# Table name: complaints
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_complaints_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Complaint, type: :model do
  let!(:user) { create(:user) }
  let!(:complaint) { create(:complaint, user: user) }

  context 'バリデーション' do
    it '有効な状態であること' do
      expect(complaint).to be_valid
    end

    it 'user_idがなければ無効な状態であること' do
      complaint = build(:complaint, user_id: nil)
      expect(complaint).not_to be_valid
    end

    it '内容がなければ無効な状態であること' do
      complaint = build(:complaint, content: nil)
      expect(complaint).not_to be_valid
    end

    it '内容が300文字以内であること' do
      complaint = build(:complaint, content: 'a' * 301)
      complaint.valid?
      expect(complaint.errors[:content]).to include('は300文字以内で入力してください')
    end
  end
end
