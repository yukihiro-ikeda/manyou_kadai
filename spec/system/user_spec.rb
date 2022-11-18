require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    context '新規ユーザを登録した場合' do
      it '登録ユーザの詳細が表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'itou'
        fill_in 'user[email]', with: 'itou@example.com'
        fill_in 'user[password]', with: 'itouitou'
        fill_in 'user[password_confirmation]', with: 'itouitou'
        click_on 'Create my account'
        expect(page).to have_content 'のページ'
      end
    end
    context 'ユーザがログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do
      it 'ログイン後、ユーザの詳細ページが表示される' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'user1@example.com'
        fill_in "session[password]", with: 'user1password'
        click_button 'Log in'
        expect(page).to have_content 'のページ'
      end
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session[email]", with: 'user1@example.com'
        fill_in "session[password]", with: 'user1password'
        click_button 'Log in'
        visit user_path(user2.id)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'user1@example.com'
        fill_in "session[password]", with: 'user1password'
        click_button 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理者機能' do
    context '管理者がログインした場合' do
      it '管理画面にアクセスできる' do
        FactoryBot.create(:second_user)
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'user2@example.com'
        fill_in "session[password]", with: 'user2password'
        click_on "Log in"
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
      it 'ユーザの新規登録ができる' do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session[email]", with: 'user2@example.com'
        fill_in "session[password]", with: 'user2password'
        click_on "Log in"
        visit admin_users_path
        click_on '新規作成'
        fill_in "user[name]", with: 'adduser'
        fill_in "user[email]", with: 'adduser@example.com'
        fill_in "user[password]", with: "adduserpassword"
        fill_in "user[password_confirmation]", with: "adduserpassword"
        click_button 'Create account'
        expect(page).to have_content 'ユーザー一覧'

      end
      it 'ユーザ詳細画面にアクセスできる' do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session[email]", with: 'user2@example.com'
        fill_in "session[password]", with: 'user2password'
        click_on "Log in"
        visit admin_users_path
        click_on "詳細"
        expect(page).to have_content '詳細'
      end
      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        FactoryBot.create(:user)
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session[email]", with: 'user2@example.com'
        fill_in "session[password]", with: 'user2password'
        click_on "Log in"
        visit admin_users_path
        click_on '編集', match: :first
        # click_on "編集"
        fill_in "user[name]", with: 'adduser'
        fill_in "user[email]", with: 'adduser@example.com'
        fill_in "user[password]", with: 'user1password'
        fill_in "user[password_confirmation]", with: 'user1password'
        click_button 'Update'
        expect(page).to have_content 'ユーザを編集しました'
      end
      it 'ユーザを削除できる' do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session[email]", with: 'user2@example.com'
        fill_in "session[password]", with: 'user2password'
        click_on "Log in"
        visit admin_users_path
        click_on "削除"
        expect(page).to have_content 'ユーザを削除しました'
      end
    end
    context '一般ユーザが管理画面にアクセスした場合' do
      it '管理画面にアクセスできない' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'user1@example.com'
        fill_in "session[password]", with: 'user1password'
        click_on "Log in"
        visit admin_users_path
        expect(current_path).to eq tasks_path
      end
    end
  end
end