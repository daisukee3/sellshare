require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let!(:user) { create(:user, :with_profile) }

  describe 'GET /profiles' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'レスポンスが正常に表示' do
        get profile_path
        expect(response).to render_template('profiles/show')
      end
    end
  end

  describe 'Edit /profiles' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '有効なプロフィール編集' do
        get edit_profile_path
        expect(response).to render_template('profiles/edit')
        patch profile_path(user), params: { profile: { introduction: '営業してます',
                                                  gender: Profile.genders.keys.sample,
                                                  age: Profile.ages.keys.sample,
                                                  type: Profile.types.keys.sample } }
        redirect_to profile_path
        follow_redirect!
        expect(response).to render_template('profiles/show')
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログイン画面にリダイレクト,401エラー発生すること' do
        # 編集
        get edit_profile_path
        expect(response).to redirect_to(new_user_session_path)

        # 更新
        patch profile_path(user), params: { profile: { introduction: '営業してます',
                                            gender: Profile.genders.keys.sample,
                                            age: Profile.ages.keys.sample,
                                            type: Profile.types.keys.sample } }
        expect(response).to have_http_status(401)
      end
    end
  end
end
