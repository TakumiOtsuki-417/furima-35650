FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
    password { password }
    password_confirmation { password }
    nickname { Faker::Name.name }
    last_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    last_name_kana { Gimei.last.katakana }
    first_name_kana { Gimei.first.katakana }
    birth { Faker::Date.between(from: '1995-09-23', to: '2014-09-25') }
  end
end
