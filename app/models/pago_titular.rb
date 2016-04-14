class PagoTitular < ActiveRecord::Base
  self.table_name = "pagos_titulares"

  belongs_to :actividad_titular
  belongs_to :pago
end
