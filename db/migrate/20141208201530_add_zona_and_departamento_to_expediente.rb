class AddZonaAndDepartamentoToExpediente < ActiveRecord::Migration
  def change
    add_reference :expedientes, :zona, index: true
    add_reference :expedientes, :departamento, index: true
  end
end
