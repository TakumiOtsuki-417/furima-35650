FactoryBot.define do
  factory :order do
    association :user, :item, :address
  end
end
