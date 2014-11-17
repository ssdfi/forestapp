namespace :db do
  namespace :import do
    desc "Importar todo: Plantaciones, Expedientes y Unificados"
    task all: :environment do
      Rake::Task["db:import:plantaciones"].invoke
      Rake::Task["db:import:expedientes"].invoke
      Rake::Task["db:import:unificados"].invoke
      Rake::Task["db:import:migrate_unificados"].invoke
    end
  end
end