require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'associations' do
    it { should have_many(:lectures) }
  end
  describe 'methods' do
    context 'self.delete_all_tracks' do
      let!(:tracks) { create_list(:track, amount) }
      let(:amount) { 5 }
      it 'should delete all tracks' do
        expect(Track.all.count).to eql(amount)
        Track.delete_all_tracks
        expect(Track.all.count).to eql(0)
      end
    end
  end
end
