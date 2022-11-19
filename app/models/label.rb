class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy, autosave: :true
  has_many :tasks, through: :labellings
end
