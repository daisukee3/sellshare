# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string           default(""), not null
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account               (account) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  context 'バリデーション' do
    it '名前、メールアドレスがあれば有効な状態であること' do
      expect(user).to be_valid
    end

    it '名前がなければ無効な状態であること' do
      user = build(:user, account: nil)
      user.valid?
      expect(user.errors[:account]).to include('を入力してください')
    end

    it '名前が30文字以内であること' do
      user = build(:user, account: 'a' * 31)
      user.valid?
      expect(user.errors[:account]).to include('は30文字以内で入力してください')
    end

    it 'メールアドレスがなければ無効な状態であること' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'メールアドレスが50文字以内であること' do
      user = build(:user, email: "#{'a' * 39}@example.com")
      user.valid?
      expect(user.errors[:email]).to include('は50文字以内で入力してください')
    end

    it '重複したメールアドレスなら無効な状態であること' do
      other_user = build(:user, email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include('はすでに存在します')
    end

    it 'メールアドレスは小文字で保存されること' do
      email = 'ExamPle@example.com'
      user = create(:user, email: email)
      expect(user.email).to eq email.downcase
    end

    it 'パスワードがなければ無効な状態であること' do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'パスワードが6文字以上であること' do
      user = build(:user, password: 'a' * 6, password_confirmation: 'a' * 6)
      user.valid?
      expect(user).to be_valid
    end
  end

  context 'フォロー機能' do
    let!(:other_user) { create(:user) }
    it 'フォローとアンフォローが正常に動作すること' do
      expect(user.has_followed?(other_user)).to be_falsey
      user.follow!(other_user)
      expect(user.has_followed?(other_user)).to be_truthy
      user.unfollow!(other_user)
      expect(user.has_followed?(other_user)).to be_falsey
      expect(user.followed_by?(other_user)).to be_falsey
    end
  end
end
