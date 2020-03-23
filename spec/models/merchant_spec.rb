require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'methods' do
    it 'can return a string for sql fragment' do
      search_params = {name: "Maybe Name"}

      expect(Merchant.query_string(search_params)).to eq("name ILIKE '%Maybe Name%'")
    end
    it "can find a single merchant based on a partial attribute" do
      merchant = create(:merchant, name: "teST Merchant")
      # extra merchant to test what comes back
      create_list(:merchant, 3)

      search_params = {name: "MERCHANT"}

      expect(Merchant.single_search(search_params)).to eq(merchant)
    end

    it "can find a many merchants based on attributes" do
      merchant_1 = create(:merchant, name: "Red MerchANT")
      merchant_2 = create(:merchant, name: "Blue Merchant")
      
      # extra items to test what comes back
      create_list(:merchant, 3)

      search_params = {name: "merchant"}

      expect(Merchant.multi_search(search_params)).to eq([merchant_1, merchant_2])
    end
  end
end
