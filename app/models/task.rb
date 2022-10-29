class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100}
  validates :detail, presence: true, length: { maximum: 500 }
end
