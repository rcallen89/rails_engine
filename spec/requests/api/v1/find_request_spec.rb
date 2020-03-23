require 'rails_helper'

RSpec.describe "Search Endpoints" do
  it 'can find a single item based on name partial and case insensitive' do
    item = create(:item, name: "nEw iTEM")

    get "/api/v1/items/find?name=ite"

    expect(response).to be_successful
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(item_json[:data][:id]).to eq(item.id.to_s)
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
  end

  it 'can find a single item based on name partial and case insensitive' do
    item = create(:item, name: "nEw iTEM", description: "blue pen")

    get "/api/v1/items/find?name=ite&description=pen"

    expect(response).to be_successful
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(item_json[:data][:id]).to eq(item.id.to_s)
    expect(item_json[:data][:type]).to eq('item')
    expect(item_json[:data][:attributes][:name]).to eq(item.name)
    expect(item_json[:data][:attributes][:description]).to eq(item.description)
    expect(item_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
  end

  it 'can return multiple items that match a search query' do
    item1 = create(:item, name: "Blue Pen")
    item2 = create(:item, name: "Red PEN")
    item3 = create(:item, name: "Green Pencil")
    item4 = create(:item, name: "Ball")

    get "/api/v1/items/find_all?name=pen"

    expect(response).to be_successful
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(item_json[:data].length).to eq(3)
  end

  it 'can find a single merchant based on name partial and case insensitive' do
    merchant = create(:merchant, name: "MERchant ONE")

    get "/api/v1/merchants/find?name=Rch"

    expect(response).to be_successful
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can find a many merchants based on a search' do
    merchant_1 = create(:merchant, name: "MERchant ONE")
    merchant_2 = create(:merchant, name: "MERchant TWO")
    merchant_3 = create(:merchant, name: "Toys R Us")
    merchant_4 = create(:merchant, name: "Another Seller")

    get "/api/v1/merchants/find_all?name=Rch"

    expect(response).to be_successful
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_json[:data].length).to eq(2)
  end
end