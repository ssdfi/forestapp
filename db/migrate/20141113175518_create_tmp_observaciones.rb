class CreateTmpObservaciones < ActiveRecord::Migration
  def change
    create_table :tmp_observaciones do |t|
      t.string :numero_interno
      t.string :numero_productor
      t.string :productor
      t.string :presentado
      t.string :certificado
      t.string :inspeccionado
      t.string :registrado
      t.string :especie
      t.string :actividad
      t.string :tipo
      t.text :observaciones
      t.string :nomenclatura_catastral
      t.string :lote
      t.string :otro
      t.index :numero_interno
      t.index :numero_productor
      t.index :productor
    end
  end
end
