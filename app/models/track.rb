class Track < ApplicationRecord
  has_many :lectures

  def self.delete_all_tracks
    # delete all lunch/networking lectures and all tracks
    Track.all.each do |t|
      Lecture.find(t.lunch_id)&.destroy unless t.lunch_id.nil?
      Lecture.find(t.networking_id)&.destroy unless t.networking_id.nil?
      t.destroy
    end
  end

end
