require 'rails_helper'

RSpec.describe "Tracks", type: :request do
  describe "GET /index" do
    let!(:tracks) { create_list(:track, amount) }
    let(:amount) { 6 }
    before { get '/tracks' }
    it 'should return http status success' do
      expect(response).to have_http_status(:success)
    end
    it 'should return track amount correctly' do
      expect(JSON.parse(response.body).count).to eql(amount)
    end
  end
end
