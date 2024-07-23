FactoryBot.define do
  factory :studytime do
    studytime_hours {1}
    studytime_minutes {0}
    memo  {Faker::Lorem.characters(number: 501)}
    image {"IMG_9995.jpeg"}
  end
end