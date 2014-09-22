namespace :db do
  namespace :import do
    desc "Importar todo: Plantaciones, Unificados y Expedientes"
    task all: :environment do
      Rake::Task["db:import:plantaciones"].invoke
      Rake::Task["db:import:unificados"].invoke
      Rake::Task["db:import:expedientes"].invoke
    end
  end
end