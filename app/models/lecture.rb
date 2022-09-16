class Lecture < ApplicationRecord
  belongs_to :track, optional: true

  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
