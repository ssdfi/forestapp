class MsExpediente < ActiveRecord::Base
  establish_connection :sqlserver
  self.table_name = 'Expedientes'
  self.primary_key = :NumExpediente

  has_many :movimientos, class_name: 'MsMovimiento', foreign_key: 'NumExpediente', primary_key: 'NumExpediente'

  def numero_interno
    "#{self.NumIntExp_Pro.to_s.rjust(2, '0')}-#{self.NumIntExp_Dto.to_s.rjust(3, '0')}-#{self.NumIntExp_Ord.to_s.rjust(3, '0')}/#{self.NumIntExp_Ano.to_s.rjust(2, '0')}"
  end
end
