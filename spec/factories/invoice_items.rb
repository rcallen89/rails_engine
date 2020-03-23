FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    unit_price { item.unit_price }
    quantity { 2 }
  end
end
