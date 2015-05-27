class RenameDepartamentos < ActiveRecord::Migration
  def change
    rename_table :departamentos, :zona_departamentos

    change_table :expedientes do |t|
      t.rename :departamento_id, :zona_departamento_id
    end
  end
end