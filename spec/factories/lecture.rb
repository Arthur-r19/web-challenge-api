FactoryBot.define do
  factory :lecture do
    name { "#{Faker::Lorem.sentence(word_count: 4)} #{Faker::Number.between(from: 1, to: 60)}min" }
  end
end
