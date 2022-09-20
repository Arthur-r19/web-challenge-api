require 'rails_helper'

RSpec.describe TrackSerializer, type: :serializer do
  let(:track) { create(:track) }
  let(:serializer) { described_class.new(track) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json) }

  it 'when all params matches' do
    expected_params = { 'id' => track.id,
                        'lectures' => track.lectures }
    expect(subject['id'] == expected_params['id']).to be_truthy
    expect(subject['lectures'] == expected_params['lectures']).to be_truthy
  end
end

