FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    unit_price { "9.99" }
  end
end
