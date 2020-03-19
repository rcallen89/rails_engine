require 'rails_helper'

RSpec.describe 'Merchant API', type: :request do
  it 'sends index of Merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
  end

  it 'sends the JSON formatted correctly' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes]).to have_key(:name)
    end
  end

  it 'can return a single merchant endpoint' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes]).to have_key(:name)
  end

  it 'can create an merchant' do
    merchant = create(:merchant)
    merchant_params = { name: "New Merchant"}

    post "/api/v1/merchants", params: merchant_params
    merchant = Merchant.last
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant.name).to eq(merchant_params[:name])
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant_params[:name])
  end

  it 'can update an merchant' do
    merchant = create(:merchant)
    merchant_update_params = {name: 'Updated Name'}

    patch "/api/v1/merchants/#{merchant.id}", params: merchant_update_params

    expect(response).to be_successful

    updated = Merchant.last
    updated_json = JSON.parse(response.body, symbolize_names: true)

    expect(updated.name).to_not eq(merchant.name)
    expect(updated.name).to eq("Updated Name")

    expect(updated_json[:data][:attributes][:name]).to eq("Updated Name")
  end

  it 'can delete an merchant' do
    create_list(:merchant, 3)

    expect(Merchant.count).to eq(3)

    merchant = Merchant.last

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(2)

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes]).to have_key(:name)
  end
end
