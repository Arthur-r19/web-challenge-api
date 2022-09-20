require 'rails_helper'

RSpec.describe LectureSerializer, type: :serializer do
  let(:lecture) { create(:lecture) }
  let(:serializer) { described_class.new(lecture) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json) }

  it 'when all params matches' do
    expected_params = { 'id' => lecture.id,
                        'name' => lecture.name,
                        'duration' => lecture.duration,
                        'start_time' => lecture.start_time }
    expect(subject).to eql(expected_params)
  end
end
