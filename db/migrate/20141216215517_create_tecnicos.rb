class CreateTecnicos < ActiveRecord::Migration
  def up
    create_table :tecnicos do |t|
      t.string :nombre
      t.boolean :activo, default: true

      t.timestamps
      t.index :nombre
    end

    change_table :expedientes do |t|
      t.rename :tecnico, :tecnico_tmp
    end

    add_reference :expedientes, :tecnico, index: true

    Expediente.find_each do |expediente|
      tecnico = Tecnico.find_by_nombre(expediente.tecnico_tmp)
      tecnico = Tecnico.create(nombre: expediente.tecnico_tmp) unless tecnico or expediente.tecnico_tmp.blank?
      expediente.tecnico = tecnico
      expediente.save!
    end

    remove_column :expedientes, :tecnico_tmp
  end

  def down
    add_column :expedientes, :tecnico_tmp, :string

    Expediente.find_each do |expediente|
      expediente.tecnico_tmp = expediente.tecnico.nombre if expediente.tecnico
      expediente.save!
    end

    remove_reference :expedientes, :tecnico
    drop_table :tecnicos

    change_table :expedientes do |t|
      t.rename :tecnico_tmp, :tecnico
    end
  end
end
