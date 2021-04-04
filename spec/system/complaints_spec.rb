require 'rails_helper'

RSpec.describe 'Complaints', type: :system do
  let!(:user) { create(:user) }
  describe 'グチ一覧ページ', js: true do
    context 'グチの登録＆削除' do
      before do
        sign_in user
      end
      it '自分のグチの登録＆削除が正常に完了すること' do
        visit complaints_path
        fill_in 'complaint[content]', with: '今日も残業頑張った'
        click_button 'グチる'
        within find('#complaint_index_new') do
          expect(page).to have_css '.card', count: 1
        end
        click_link('削除する')
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_css '.card', count: 1
      end
    end
  end
end
