class Lecture < ApplicationRecord
  before_validation :parse_lecture

  belongs_to :track, optional: true

  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }

  scope :by_not_lunch_nor_networking, -> { where('name != ?', 'Almoço').where('name != ?', 'Evento de Networking') }

  def parse_lecture
    if self.name == 'Almoço' || self.name == 'Evento de Networking'
      self.duration = 60
      return
    end

    last_string = self.name.split.last
    if last_string == 'lightning'
      duration = 5
    else
      duration = last_string.delete('a-zA-Z').to_i
    end
    self.duration = duration
  end

  def self.reset_all_lectures
    # remove all lectures associations and reset start_time
    Lecture.update(start_time: nil, track: nil)
  end

end
