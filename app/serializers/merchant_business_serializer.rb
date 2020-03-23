class MerchantBusinessSerializer
  include FastJsonapi::ObjectSerializer
  attribute :revenue do |merchant|
    merchant.revenue
  end
end
