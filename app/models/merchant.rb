class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices

  def self.query_string(search_params)
    search_params.keys.map {|att| "#{att} ILIKE '%#{search_params[att]}%'"}.join(' AND ')
  end

  def self.single_search(search_params)
    where(query_string(search_params)).first
  end

  def self.multi_search(search_params)
    where(query_string(search_params))
  end

  def self.most_revenue(limit)
    joins(:transactions).joins(:invoice_items)
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where(:transactions => {result: 'success'})
    .group(:id)
    .order('revenue desc')
    .limit(limit)
  end

  def self.items_sold(limit)
    joins(:invoices => :transactions).joins(:invoice_items)
    .where("transactions.result = 'success'")
    .select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
    .group(:id).order('items_sold desc').limit(limit)
  end

  def revenue
    invoices.joins(:transactions)
    .where(:transactions => {result: 'success'})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
