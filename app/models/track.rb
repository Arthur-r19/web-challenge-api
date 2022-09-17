class Track < ApplicationRecord
  has_many :lectures

  def delete_all_tracks
    # delete all lunch/networking lectures and all tracks
    Track.all.each do |t|
      Lecture.find(t.lunch_id)&.destroy
      Lecture.find(t.networking_id)&.destroy
      t.destroy
    end
  end

end
