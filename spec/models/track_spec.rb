require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'associations' do
    it { should have_many(:lecture) }
  end
end
