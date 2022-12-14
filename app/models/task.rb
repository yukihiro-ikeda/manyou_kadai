class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy, autosave: :true
  has_many :labels, through: :labellings
  belongs_to :user
  validates :name, presence: true, length: { maximum: 100}
  validates :detail, presence: true, length: { maximum: 500 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }
  scope :status_name, -> (status){ where(status: status)}
  scope :task_name, -> (name){ where('name Like(?)', "%#{name}%") }
end
