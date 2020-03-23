require 'rails_helper'

RSpec.describe 'Business Logic Endpoints' do
  before :each do
    # Create Entities
    customer = create(:customer)
    @merchant_1 = create(:merchant, name: "Merchant 1")
    @merchant_2 = create(:merchant, name: "Merchant 2")
    @merchant_3 = create(:merchant, name: "Merchant 3")

    # Create Items for each merchant
    @merchant_1_items = 3.times.map {create(:item, merchant: @merchant_1)}
    @merchant_2_items = 3.times.map {create(:item, merchant: @merchant_2)}
    @merchant_3_items = 3.times.map {create(:item, merchant: @merchant_3)}

    # Create empty invoices for each merchant
    @merchant_1_invoices = 3.times.map {create(:invoice, merchant: @merchant_1, customer: customer)}
    @merchant_2_invoices = 3.times.map {create(:invoice, merchant: @merchant_2, customer: customer)}
    @merchant_3_invoices = 3.times.map {create(:invoice, merchant: @merchant_3, customer: customer)}

    #Create Invoice Items for each invoice
    # Merchant 1 has the most sold items
    @m1_invoiceitems = @merchant_1_invoices.map {|invoice| create(:invoice_item, item: @merchant_1_items.sample, invoice: invoice, unit_price: 1.00, quantity: 20)}
    # Merchant 2 has the most items in each invoice
    @m2_invoiceitems = @merchant_2_invoices.map {|invoice| create(:invoice_item, item: @merchant_2_items.sample, invoice: invoice, quantity: 5)}
    # Merchant 3 is going to have the most successful transactions
    @m3_invoiceitems = @merchant_3_invoices.map {|invoice| create(:invoice_item, item: @merchant_3_items.sample, invoice: invoice)}

    # Merchant 1 Transactions - $20, 2 items sold
    create(:transaction, invoice: @merchant_1_invoices[0], result: "failed")
    create(:transaction, invoice: @merchant_1_invoices[1], result: "failed")
    create(:transaction, invoice: @merchant_1_invoices[2], result: "failed")
    create(:transaction, invoice: @merchant_1_invoices[2], result: "success")

    # Merchant 2 Transactions $50 10 items sold
    create(:transaction, invoice: @merchant_2_invoices[0], result: "failed")
    create(:transaction, invoice: @merchant_2_invoices[1], result: "success")
    create(:transaction, invoice: @merchant_2_invoices[2], result: "success")

    # Merchant 3 Transactions $30 6 items sold
    create(:transaction, invoice: @merchant_3_invoices[0], result: "success")
    create(:transaction, invoice: @merchant_3_invoices[1], result: "success")
    create(:transaction, invoice: @merchant_3_invoices[2], result: "success")

  end

  it 'can return the top X merchants based on revenue' do
    limit = 3
    get "/api/v1/merchants/most_revenue?quantity=#{limit}"

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:data].length).to eq(limit)
    expect(results[:data][0][:attributes][:name]).to eq(@merchant_2.name) 
    expect(results[:data][1][:attributes][:name]).to eq(@merchant_3.name) 
    expect(results[:data][2][:attributes][:name]).to eq(@merchant_1.name) 
  end

  it 'can return the top X merchants based on told items sold' do
    limit = 2
    get "/api/v1/merchants/most_items?quantity=#{limit}"

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results[:data].length).to eq(limit)
    expect(results[:data][0][:attributes][:name]).to eq(@merchant_1.name) 
    expect(results[:data][1][:attributes][:name]).to eq(@merchant_2.name) 
  end

  it 'can return revenue based on a single merchant' do
    get "/api/v1/merchants/#{@merchant_1.id}/revenue"

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results[:data][:attributes][:revenue]).to eq(20.0)
  end
end