FactoryBot.define do
  factory :lecture do
    name { Faker::Name.name.delete('.') }
  end
end