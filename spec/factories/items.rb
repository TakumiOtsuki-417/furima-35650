FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 300, to: 9999999) }
    genre_id { Faker::Number.between(from: 2, to: 11) }
    status_id { Faker::Number.between(from: 2, to: 7) }
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id { Faker::Number.between(from: 2, to: 4) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/testimage.png'), filename: 'testimage.png')
    end
  end
end
