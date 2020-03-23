class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.query_string(search_params)
    search_params.keys.map {|att| "#{att} ILIKE '%#{search_params[att]}%'"}.join(' AND ')
  end

  def self.single_search(search_params)
    where(query_string(search_params)).first
  end

  def self.multi_search(search_params)
    where(query_string(search_params))
  end
end
