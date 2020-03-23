require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'methods' do
    it 'can return a string for sql fragment' do
      search_params = {name: "Item Name", description: "Description"}

      expect(Item.query_string(search_params)).to eq("name ILIKE '%Item Name%' AND description ILIKE '%Description%'")
    end
    it "can find a single item based on a partial attribute" do
      item = create(:item, name: "teST ITEM", description: "THIS is a Test ITEM")
      # extra items to test what comes back
      create_list(:item, 3)

      search_params = {name: "tem"}

      expect(Item.single_search(search_params)).to eq(item)
    end

    it "can find a single item based on a multiple partial attributes" do
      item = create(:item, name: "Red Pen", description: "Red")
      item_2 = create(:item, name: "Blue Pen", description: "Blue")
      
      # extra items to test what comes back
      create_list(:item, 3)

      search_params = {name: "pen", description: "blue"}

      expect(Item.single_search(search_params)).to eq(item_2)
    end

    it "can find a many items based on attributes" do
      item_1 = create(:item, name: "Red Pen", description: "Red")
      item_2 = create(:item, name: "Blue Pen", description: "Blue")
      
      # extra items to test what comes back
      create_list(:item, 3)

      search_params = {name: "pen"}

      expect(Item.multi_search(search_params)).to eq([item_1, item_2])
    end
  end
end
