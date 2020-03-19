require 'rails_helper'

RSpec.describe "Factory Bot Stuff" do
  xit 'can make advanced relationships quickly' do
    require 'pry'; binding.pry
    invoice_item = create(:invoice_item)
    require 'pry'; binding.pry
  end

  xit 'the defaults for relationships can be overridden' do
    require 'pry'; binding.pry
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    require 'pry'; binding.pry
  end

  it 'the defaults for relationships can be overridden' do
    require 'pry'; binding.pry
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant)
    ii = create(:invoice_item, item: item, invoice: invoice )
    require 'pry'; binding.pry
  end
end