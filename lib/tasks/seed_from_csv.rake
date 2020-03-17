namespace :csv_import do
  desc "Seed csv files from db/csv_seeds to database"
end


task seed_from_csv: :environment do
  require 'csv'
  'db:reset'
  Dir.foreach('db/csv_seeds') do |csv|
    if csv != "." && csv != ".."
      CSV.foreach("db/csv_seeds/#{csv}", headers: true) do |row|
        require 'pry'; binding.pry
      end
    end
  end
end
