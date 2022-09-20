require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'associations' do
    it { should have_many(:lecture) }
  end
  describe 'methods' do
    context 'self.delete_all_tracks' do
      let!(:lectures) { create_list(:lecture, 12, name: 'palestra 60min') }
      before do
        TrackBuilder.create_schedule
      end
      it 'should delete all tracks' do
        expect(Track.all.count).to eql(2)
        Track.delete_all_tracks
        expect(Track.all.count).to eql(0)
      end
    end
  end
end
