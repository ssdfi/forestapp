require 'expedientes_importer'

namespace :db do
  namespace :import do
    desc "Importar Expedientes desde base de datos SQL Server"
    task expedientes: :environment do
      importer = ExpedientesImporter.new
      importer.import
      puts "TOTAL DE REGISTROS IMPORTADOS: #{importer.data}"
    end
  end
end