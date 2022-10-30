require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', detail: '')
        expect(task).not_to be_valid
        # ここに内容を記載する
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', detail: '成功テスト')
        expect(task).to be_valid
        # ここに内容を記載する
      end
    end
  end
  #pending "add some examples to (or delete) #{__FILE__}"
end
