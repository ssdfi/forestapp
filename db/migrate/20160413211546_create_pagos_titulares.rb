class CreatePagosTitulares < ActiveRecord::Migration
  def change
    create_table :pagos_titulares do |t|
      t.references :pago, index: true
      t.references :actividad_titular, index: true
    end
  end
end
