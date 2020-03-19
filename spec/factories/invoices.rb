FactoryBot.define do
  factory :invoice do
    customer
    merchant 
    status { "Pending" }
  end
end
