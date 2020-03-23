namespace :csv_import do
  desc "Seed csv files from db/csv_seeds to database"
end


task seed_from_csv: :environment do
  require 'csv'

  # silence_stream(STDOUT) do
  #   Rake::Task['db:reset'].invoke
  # end
  system "rake db:reset > /dev/null"
  # Transaction.delete_all
  # InvoiceItem.delete_all
  # Invoice.delete_all
  # Item.delete_all
  # Customer.delete_all
  # Merchant.delete_all

  CSV.foreach('db/csv_seeds/customers.csv', headers: true) do |row|
    customer = Customer.new(row.to_a[1..-1].to_h)
    customer.id = row[0]
    customer.save
  end
  puts 'Customers Seeded'

  CSV.foreach('db/csv_seeds/merchants.csv', headers: true) do |row|
    Merchant.create(row.to_a[1..-1].to_h)
  end
  puts 'Merchants Seeded'

  CSV.foreach('db/csv_seeds/items.csv', headers: true) do |row|
    item = Item.new(row.to_a[1..-1].to_h)
    item.unit_price = (item.unit_price / 100)
    item.save
  end
  puts 'Items Seeded'

  CSV.foreach('db/csv_seeds/invoices.csv', headers: true) do |row|
    Invoice.create(row.to_a[1..-1].to_h)
  end

  CSV.foreach('db/csv_seeds/invoice_items.csv', headers: true) do |row|
    invoiceitem = InvoiceItem.new(row.to_a[1..-1].to_h)
    invoiceitem.unit_price = (invoiceitem.unit_price / 100)
    invoiceitem.save
  end
  puts 'Invoices Seeded'

  CSV.foreach('db/csv_seeds/transactions.csv', headers: true) do |row|
    Transaction.create(row.to_a[1..-1].to_h)
  end
  puts 'Transactions Seeded'
  # Dir.foreach('db/csv_seeds') do |csv|
  #   if csv != "." && csv != ".."
  #     CSV.foreach("db/csv_seeds/#{csv}", headers: true) do |row|
  #       require 'pry'; binding.pry
  #     end
  #   end
  # end
end
