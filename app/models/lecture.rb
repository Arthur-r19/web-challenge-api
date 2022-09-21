class Lecture < ApplicationRecord
  before_validation :parse_lecture

  belongs_to :track, optional: true

  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }
  validate :no_numbers_on_name

  scope :by_not_lunch_nor_networking, -> { where('name != ?', 'Almoço').where('name != ?', 'Evento de Networking') }

  def parse_lecture
    self.name = name&.split&.join(' ')
    return if name.nil? || name.empty? || name.capitalize == 'Almoço' || name.capitalize == 'Evento de networking'

    last_string = name.split.last
    if last_string == 'lightning'
      duration = 5
    elsif last_string.reverse[0..2] == 'nim'
      duration = last_string&.delete('a-zA-Z').to_i
    else
      self.duration = 0
      return
    end
    self.duration = duration
  end

  def no_numbers_on_name
    title = name&.split
    title&.pop
    title = title&.join(' ')
    return if title&.match(/\d+/).nil?

    errors.add(:name, 'não pode conter números')
  end

  def self.reset_all_lectures
    # remove all lectures associations and reset start_time
    Lecture.update(start_time: nil, track: nil)
  end

end
