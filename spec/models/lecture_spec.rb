require 'rails_helper'

RSpec.describe Lecture, type: :model do
  describe 'validations' do
    context 'name' do
      it { should validate_presence_of(:name) }
    end
    context 'duration' do
      it { should validate_presence_of(:duration) }
      it { should validate_numericality_of(:duration).only_integer }
      it { should validate_numericality_of(:duration).is_less_than_or_equal_to(180) }
      it { should validate_numericality_of(:duration).is_greater_than(0) }
    end
  end
  describe 'associations' do
    it { should belong_to(:track).optional }
  end
  describe 'methods' do
    context 'parse_lecture' do
      it 'should set lunch duration correctly' do
        lecture = Lecture.new(name: 'Almoço')
        lecture.parse_lecture
        expect(lecture.duration).to eql(60)
      end
      it 'should set lunch duration correctly on save' do
        lecture = Lecture.new(name: 'Almoço')
        lecture.save
        expect(lecture.duration).to eql(60)
      end
      it 'should set networking duration correctly' do
        lecture = Lecture.new(name: 'Evento de Networking')
        lecture.parse_lecture
        expect(lecture.duration).to eql(60)
      end
      it 'should set networking duration correctly on save' do
        lecture = Lecture.new(name: 'Evento de Networking')
        lecture.save
        expect(lecture.duration).to eql(60)
      end
      it 'should set lecture duration correctly' do
        duration = Faker::Number.between(from: 1, to: 60)
        lecture = Lecture.new(name: "lecture #{duration}min")
        lecture.parse_lecture
        expect(lecture.duration).to eql(duration)
      end
      it 'should set lecture duration correctly on save' do
        duration = Faker::Number.between(from: 1, to: 60)
        lecture = Lecture.new(name: "lecture #{duration}min")
        lecture.save
        expect(lecture.duration).to eql(duration)
      end
    end
    context 'self.reset_all_lectures' do
      let(:track) { Track.create }
      let(:start_time) { Time.utc(2000, 1, 1, 9) }
      let(:amount) { 10 }
      let!(:lecs) { create_list(:lecture, amount, start_time: start_time, track: track) }
      it 'should reset all lectures start time and associations' do
        expect(Lecture.where(track: track).count).to eql(amount)
        expect(Lecture.where(start_time: start_time).count).to eql(amount)
        Lecture.reset_all_lectures
        expect(Lecture.where(track: nil).count).to eql(amount)
        expect(Lecture.where(start_time: nil).count).to eql(amount)
      end
    end
  end
  
  
  
  
  
  
end
