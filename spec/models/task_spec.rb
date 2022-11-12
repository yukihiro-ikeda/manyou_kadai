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
  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
      # 必要に応じて、テストデータの内容を変更して構わない
      let!(:task) { FactoryBot.create(:task, name: 'テスト', status: '未着手') }
      let!(:second_task) { FactoryBot.create(:second_task, name: "トステ", status: '完了') }
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.task_name('テス')).to include(task)
          expect(Task.task_name('テスト')).not_to include(second_task)
          expect(Task.task_name('テスト').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          expect(Task.status_name('未着手')).to include(task)
          expect(Task.status_name('未着手')).not_to include(second_task)
          expect(Task.status_name('未着手').count).to eq 1
          # ここに内容を記載する
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          expect(Task.task_name('テスト') && Task.status_name('未着手')).to include(task)
          expect(Task.task_name('テスト') && Task.status_name('未着手')).not_to include(second_task)
          expect(Task.task_name('テスト') && Task.status_name('未着手').count).to eq 1# ここに内容を記載する
        end
      end
    end
  end
  #pending "add some examples to (or delete) #{__FILE__}"
end
