class TrackSerializer < ActiveModel::Serializer
  attributes :id
  has_many :lectures do
    object.lectures.order(start_time: :asc)
  end
end
