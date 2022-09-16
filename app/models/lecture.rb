class Lecture < ApplicationRecord
  before_validation :parse_lecture

  belongs_to :track, optional: true

  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def parse_lecture
    last_string = self.name.split.last
    if last_string == 'lightning'
      duration = 5
    else
      duration = last_string.delete('a-zA-Z').to_i
    end
    self.duration = duration
  end
end
