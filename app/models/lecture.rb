class Lecture < ApplicationRecord
  belongs_to :track, optional: true

  validates :name, presence: true
  validates :duration, presence: true
end
