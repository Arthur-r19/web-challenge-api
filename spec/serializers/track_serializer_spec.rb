require 'rails_helper'

RSpec.describe TrackSerializer, type: :serializer do
  let(:competition) { create(:competition) }
  let(:serializer) { described_class.new(competition) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json)['competition'] }

  it 'when all params matches' do
    expected_params = {
      'id' => competition.id,
      'name' => competition.name
    }
    expect(subject).to eql(expected_params)
  end
end

