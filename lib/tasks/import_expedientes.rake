require 'expedientes_importer'

namespace :db do
  namespace :import do
    desc "Importar Expedientes desde base de datos SQL Server"
    task expedientes: :environment do
      start_time = Time.now
      puts "\n######################################################################################"
      puts "IMPORTANDO EXPEDIENTES... (#{start_time})"
      puts "######################################################################################"
      importer = ExpedientesImporter.new
      importer.import
      puts "#####################################################################################################"
      puts "TOTAL DE EXPEDIENTES IMPORTADOS: #{importer.data} (#{ChronicDuration.output(Time.now - start_time)})"
      puts "#####################################################################################################"
    end
  end
end