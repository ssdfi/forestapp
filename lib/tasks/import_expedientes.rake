require 'expedientes_importer'

namespace :db do
  namespace :import do
    desc "Importar Expedientes desde base de datos SQL Server"
    task expedientes: :environment do
      puts "\n######################################################################################"
      puts "IMPORTANDO EXPEDIENTES..."
      puts "######################################################################################"
      importer = ExpedientesImporter.new
      importer.import
      puts "######################################################################################"
      puts "TOTAL DE EXPEDIENTES IMPORTADOS: #{importer.data}"
      puts "######################################################################################"
    end
  end
end