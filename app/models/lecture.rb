class Lecture < ApplicationRecord
  before_validation :parse_lecture

  belongs_to :track, optional: true

  validates :name, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }
  validate :no_numbers_on_name
  validate :lunch_and_networking_belong_to_track

  scope :by_not_lunch_nor_networking, -> { where('name != ?', 'Almoço').where('name != ?', 'Evento de Networking') }

  def parse_lecture
    return if name.nil? || name.empty?

    if name.capitalize == 'Almoço' || name.capitalize == 'Evento de networking'
      self.duration = 60
      return
    end

    last_string = name.split.last
    if last_string == 'lightning'
      duration = 5
    elsif last_string.reverse[0..2] == 'nim'
      duration = last_string&.delete('a-zA-Z').to_i
    else
      return
    end
    self.duration = duration
  end

  def no_numbers_on_name
    title = name&.split
    title&.pop
    title = title&.join(' ')
    return if title&.match(/\d+/).nil?

    errors.add(:name_with_numbers, 'O nome da palestra não pode conter números.')
  end

  def lunch_and_networking_belong_to_track
    return unless name&.capitalize == 'Almoço' || name&.capitalize == 'Evento de networking'
    return unless track.nil?

    errors.add(:association, 'Eventos de almoço e networking não podem ser criados manualmente.')
  end

  def self.reset_all_lectures
    # remove all lectures associations and reset start_time
    Lecture.update(start_time: nil, track: nil)
  end

end
