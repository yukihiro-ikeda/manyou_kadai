require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  describe do
    before do
      visit new_session_path
      fill_in "session[email]", with: 'user1@example.com'
      fill_in "session[password]", with: 'user1password'
      click_button 'Log in'
    end

    describe 'ラベル登録機能' do
      context 'タスク新規登録でラベルを選択した場合' do
        it '登録したラベルが一覧画面で表示される' do
          visit new_task_path
          fill_in "task[name]", with: 'テストタスク'
          fill_in "task[detail]", with: 'テスト内容'
          fill_in "task[expired_at]", with: "002020-11-11"
          select '未着手', from: 'task[status]'
          select '高', from: 'task[priority]'
          check "task[label_ids][]"
          click_button '登録する'
          expect(page).to have_content 'test_label'
        end
      end
    end
  end  
end