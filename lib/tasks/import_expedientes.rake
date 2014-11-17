require 'expedientes_importer'

namespace :db do
  namespace :import do
    desc "Importar Expedientes desde base de datos SQL Server"
    task expedientes: :environment do
      importer = ExpedientesImporter.new
      importer.import
      puts "\n######################################################################################"
      puts "TOTAL DE REGISTROS IMPORTADOS: #{importer.data}"
      puts "######################################################################################"
    end
  end
end