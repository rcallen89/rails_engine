class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.single_search(search_params))
  end

  def index
    render json: MerchantSerializer.new(Merchant.multi_search(search_params))
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end


end