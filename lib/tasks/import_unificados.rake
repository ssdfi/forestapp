require 'unificados_importer'

namespace :db do
  namespace :import do
    desc "Importar Unificados desde archivos Shape"
    task unificados: :environment do
      dirs = Rails.application.config.path_unificados + '/**'

      subtotal = 0
      total = 0

      Dir[dirs].each do |dir|
        Dir[dir + '/*.shp'].each do |file|
          next if File.basename(file)[4..5] == 'pr'
          #next unless File.basename(file) == '1301plap.shp'
          importer = UnificadosImporter.new(file)
          if importer.import
            subtotal += importer.data[:registros]
          end
        end
        puts "Registros importados de #{File.basename(dir)}: #{subtotal}"
        total += subtotal
        subtotal = 0
      end

      puts "\n######################################################################################"
      puts "TOTAL DE UNIFICADOS IMPORTADOS: #{total}"
      puts "######################################################################################"
    end
  end
end