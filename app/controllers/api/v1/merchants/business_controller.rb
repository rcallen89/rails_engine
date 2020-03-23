class Api::V1::Merchants::BusinessController < ApplicationController

  def most_revenue
    # render json: MerchantSerializer.new(Merchant.joins(:invoice_items).joins({:invoice_items => :transactions}).where("transactions.result = 'success'").select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').group(:id).order('revenue desc').limit(params[:quantity]))
    # render json: MerchantSerializer.new(Merchant.joins(:invoices => :transactions).joins(:invoice_items).where("transactions.result = 'success'").select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').group(:id).order('revenue desc').limit(params[:quantity]))
    # render json: MerchantSerializer.new(Merchant.joins(:invoices => :transactions).joins(:invoice_items).select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').group(:id).order('revenue desc').limit(params[:quantity]))
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def most_items
    # render json: MerchantSerializer.new(Merchant.joins(:invoice_items).joins({:invoice_items => :transactions}).where("transactions.result = 'success'").select('merchants.*, SUM(invoice_items.quantity)AS items_sold').group(:id).order('items_sold desc').limit(params[:quantity]))
    render json: MerchantSerializer.new(Merchant.items_sold(params[:quantity]))
  end

  def revenue
    render json: MerchantBusinessSerializer.new(Merchant.find(params[:id]))
  end

end