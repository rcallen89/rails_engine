class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.single_search(search_params))
  end

  def index
    render json: ItemSerializer.new(Item.multi_search(search_params))
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end


end