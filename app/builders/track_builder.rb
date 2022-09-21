class TrackBuilder

  class << self
    def create_schedule
      Track.delete_all_tracks
      Lecture.reset_all_lectures
      lectures = []
      Lecture.by_not_lunch_nor_networking.order(duration: :desc).each { |l| lectures.append(l) }
      while lectures.count > 0
        track = Track.create
        # morning schedule (9h - 12h)
        assemble_lectures(Time.utc(2000, 1, 1, 9), 180, lectures, track)
        add_lunch(track)
        # afternoon schedule (13h - 16/17h)
        time = assemble_lectures(Time.utc(2000, 1, 1, 13), 240, lectures, track)
        start_time = networking_start_time(time)
        add_networking(track, start_time)
      end
    end

    def assemble_lectures(start_time, time_left, lectures, track)
      index = 0
      while time_left > 0 && index < lectures.count
        if lectures[index].duration <= time_left
          lec = lectures.delete_at(index)
          lec.update(start_time: start_time, track: track)
          time_left -= lec.duration
          start_time += lec.duration.minutes
        else
          index += 1
        end
      end
      start_time
    end

    def add_lunch(track)
      lunch = Lecture.create(name: 'Almoço', duration: 60, start_time: Time.utc(2000, 1, 1, 12), track: track)
      track.update(lunch_id: lunch.id)
    end

    def add_networking(track, start_time)
      networking = Lecture.create(name: 'Evento de Networking', duration: 60, start_time: start_time, track: track)
      track.update(networking_id: networking.id)
    end

    def networking_start_time(time)
      return time if time > Time.utc(2000, 1, 1, 16)

      Time.utc(2000, 1, 1, 16)
    end
  end

end
