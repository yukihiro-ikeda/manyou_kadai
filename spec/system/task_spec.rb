require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: '洗濯'
        fill_in 'task[detail]', with: '上着'
        fill_in "task[expired_at]", with: "002022-12-31"
        select '未着手', from: 'task[status]'
        click_on '登録する'
        expect(page).to have_content '洗濯'
        expect(page).to have_content '上着'
        expect(page).to have_content '2022-12-31'
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, name: '11月1日にすること')
        FactoryBot.create(:task, name: '11月2日にすること')
        visit tasks_path
        list = all('.task_list')
        expect(list[1]).to have_content "11月1日にすること"
        expect(list[0]).to have_content "11月2日にすること"
      end
    end
    context' 終了期限でソートする場合'do
      it '終了期限が降順で表示される'do
        FactoryBot.create(:task, name: 'テスト1')
        FactoryBot.create(:second_task, name: 'テスト2')
        visit tasks_path
        click_on "終了期限でソートする"
        sleep(2)
        list = all('.task_list')
        expect(list[1]).to have_content 'テスト2'
        expect(list[0]).to have_content 'テスト1'
      end
    end
  end

  describe '検索機能' do  
    context 'タスク名であいまい検索した場合' do
      it 'キーワードを含むタスク名のタスクが表示される' do
        FactoryBot.create(:task, name: 'テストテスト', detail: '完了')
        FactoryBot.create(:task, name: 'テスト', detail: '未着手')
        visit tasks_path
        fill_in "task[name]", with: "スト"
        click_button 'Search'
        expect(page).to have_content 'テストテスト'
        expect(page).to have_content 'テスト'
      end
    end
    context 'ステータス検索した場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        FactoryBot.create(:task, name: 'テスト', status: '未着手')
        visit tasks_path
        select '未着手', from: 'task[status]'
        click_button 'Search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タスク名のあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタスク名に含み、かつステータスが完全一致するタスクで絞り込まれる" do
        FactoryBot.create(:task, name: 'テストテスト', status: '未着手')
        FactoryBot.create(:task, name: 'テスト', status: '完了')
        visit tasks_path
        fill_in "task[name]", with: 'スト'
        select '未着手', from: 'task[status]'
        click_on 'Search'
        expect(page).to have_content 'テストテスト'
        expect(page).to have_selector 'td', text: '未着手'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, name: 'send', detail: 'mail')
         visit task_path(task.id)
         expect(page).to have_content 'send'
         expect(page).to have_content 'mail'
       end
     end
  end
end