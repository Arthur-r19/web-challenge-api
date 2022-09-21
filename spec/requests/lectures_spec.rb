require 'rails_helper'

RSpec.describe "Lectures", type: :request do
  describe "GET /index" do
    let!(:lectures) { create_list(:lecture, amount) }
    let(:amount) { 10 }
    before { get '/lectures' }
    it 'should return http status success' do
      expect(response).to have_http_status(:success)
    end
    it 'should return only scoped lectures successfully' do
      expect(JSON.parse(response.body).count).to eql(amount)
    end
  end
  describe 'GET /show' do
    let(:lecture) { create(:lecture) }
    before { get "/lectures/#{lecture.id}" }
    it 'should return http status success' do
      expect(response).to have_http_status(:success)
    end
    it 'should return json keys correctly' do
      expect(JSON.parse(response.body).keys).to include('id', 'name', 'duration', 'start_time')
    end
  end
  describe 'POST /create' do
    let(:params) { { lecture: attributes_for(:lecture) } }
    before do
      expect(TrackBuilder).to receive(:create_schedule)
      post '/lectures', params: params
    end
    it 'should return http status created' do
      expect(response).to have_http_status(:created)
    end
    it 'should return json keys correctly' do
      expect(JSON.parse(response.body).keys).to include('id', 'name', 'duration', 'start_time')
    end
  end
  describe 'POST /create_batch' do
    let(:params) { { lecture: { file: fixture_file_upload('proposals.txt', 'text/plain') } } }
    before do
      expect(TrackBuilder).to receive(:create_schedule).and_call_original
      post '/lectures/batch', params: params
    end
    it 'should return http status created' do
      expect(response).to have_http_status(:created)
    end
    it 'should return tracks schedule correctly' do
      track1 = JSON.parse(response.body)[0]['lectures']
      track2 = JSON.parse(response.body)[1]['lectures']
      expect(JSON.parse(response.body).count).to eql(2)
      expect(track1.count + track2.count).to eql(23)
    end
  end
  describe 'PUT /update' do
    let(:lecture) { create(:lecture) }
    let(:params) { { lecture: attributes_for(:lecture) } }
    before do
      expect(TrackBuilder).to receive(:create_schedule).and_call_original
      put "/lectures/#{lecture.id}", params: params
    end
    it 'should return http status success' do
      expect(response).to have_http_status(:success)
    end
    it 'should update lecture params correctly' do
      lec = Lecture.find(lecture.id)
      expect(lec.name).to eql(params[:lecture][:name])
    end
  end
  describe 'DELETE /destroy' do
    let(:lectures) { create_list(:lecture, amount) }
    let(:amount) { 10 }
    before do
      expect(TrackBuilder).to receive(:create_schedule).and_call_original
      delete "/lectures/#{lectures[0].id}"
    end
    it 'should return http status success' do
      expect(response).to have_http_status(:success)
    end
    it 'should delete lecture successfully' do
      expect(Lecture.find_by(id: lectures[0].id)).to be_nil
    end
  end
end
