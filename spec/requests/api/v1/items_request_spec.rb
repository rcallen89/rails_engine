require 'rails_helper'

RSpec.describe 'Item API', type: :request do
  it 'sends index of Items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it 'sends the JSON formatted correctly' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item[:type]).to eq("item")
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:merchant_id)
    end
  end

  it 'can return a single item endpoint' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
  end

  it 'can create an item' do
    merchant = create(:merchant)
    item_params = {
                   name: "New Item",
                   description: "New Item Description",
                   unit_price: 15.5,
                   merchant_id: merchant.id
    }

    post "/api/v1/items", params: item_params
    item = Item.last
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item.name).to eq(item_params[:name])
    # require 'pry'; binding.pry
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_json[:data][:attributes][:description]).to eq(item_params[:description])
    expect(item_json[:data][:attributes][:unit_price]).to eq(15.5)
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item_params[:merchant_id])

  end
end