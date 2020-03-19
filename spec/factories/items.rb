FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.color() }
    unit_price { 5.00 }
    merchant
  end
end
