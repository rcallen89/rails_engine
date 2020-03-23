FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { 1234123412341234 }
    credit_card_expiration_date { 1 }
    result { "success" }
  end
end
