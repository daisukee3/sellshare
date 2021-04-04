require 'rails_helper'

RSpec.describe 'Complaints', type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'グチの登録' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'Ajaxで有効な内容のグチが登録できること' do
        expect {
          post complaints_path, xhr: true, params: { complaint: { content: '今日も文句言わず頑張ったよ' } }
        }.to change(Complaint, :count).by(1)
      end

      it 'Ajaxで無効な内容のコメントが登録できないこと' do
        expect {
          post complaints_path, xhr: true, params: { complaint: { content: '' } }
        }.not_to change(Complaint, :count)
      end
    end

    context 'ログインしていない場合' do
      it 'グチ登録ページにアクセスできずログインフォームへリダイレクトされる' do
        get complaints_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
      it 'グチは登録できない' do
        expect {
          post complaints_path, xhr: true, params: { complaint: { content: '今日も文句言わず頑張ったよ' } }
        }.not_to change(Complaint, :count)
      end
    end
  end

  context 'グチの削除' do
    let!(:complaint) { create(:complaint, user: user) }
    context 'ログインしている場合' do
      context 'グチを作成したユーザーである場合' do
        before do
          sign_in user
        end
        it 'Ajaxでグチの削除ができること' do
          expect {
            delete complaint_path(complaint), xhr: true
          }.to change(Complaint, :count).by(-1)
        end
      end
      context 'グチを作成したユーザーでない場合' do
        before do
          sign_in other_user
        end
        it 'Ajaxでグチの削除はできないこと' do
          expect {
            delete complaint_path(complaint), xhr: true}
            .not_to change(Complaint, :count)
        end
      end
    end

    context 'ログインしていない場合' do
      it 'Ajaxでグチの削除はできない' do
        expect {
          delete complaint_path(complaint), xhr: true
        }.not_to change(Complaint, :count)
      end
    end
  end
end
