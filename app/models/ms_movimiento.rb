class MsMovimiento < ActiveRecord::Base
  establish_connection :sqlserver
  self.table_name = 'Movimientos'
  self.primary_key = 'NumExpediente'

  belongs_to :expediente, class_name: 'MsExpediente', foreign_key: 'NumExpediente', primary_key: 'NumExpediente'
end
