require 'rails_helper'

RSpec.describe 'News_apis', type: :system do
  let!(:user) { create(:user) }
  describe 'News一覧ページ' do
    context 'ログインしてる場合' do
      before do
        sign_in user
      end
      it 'BusinessNewsが表示される' do
        visit news_index_path
        expect(page).not_to have_css '.yahoo_link', count: 20
      end
    end
  end
end