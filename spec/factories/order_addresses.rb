FactoryBot.define do
  factory :order_address do
    postal_code { Faker::Number.number(digits: 3).to_s + "-" + Faker::Number.number(digits: 4).to_s }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Gimei.city.kanji }
    house_number { Gimei.town.kanji }
    building_name { Faker::Lorem.sentence }
    phone_number { Faker::Number.number(digits: 11) }
    token { "tok_abcdefghijk00000000000000000" }
  end
end
