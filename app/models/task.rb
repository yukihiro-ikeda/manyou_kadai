class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100}
  validates :detail, presence: true, length: { maximum: 500 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
end
