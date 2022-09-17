class LectureSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :start_time

  # def start_time
  #   object.start_time.to_s[11..15]
  # end
end
