class MsExpediente < ActiveRecord::Base
  establish_connection :sqlserver
  self.table_name = 'Expedientes'
  self.primary_key = :NumExpediente

  has_many :movimientos, class_name: 'MsMovimiento', foreign_key: 'NumExpediente', primary_key: 'NumExpediente'

  ##
  # Genera el número interno a partir de los los atributos NumIntExp_Pro, NumIntExp_Dto, NumIntExp_Ord y NumIntExp_Ano
  def numero_interno
    "#{self.NumIntExp_Pro.to_s.rjust(2, '0')}-#{self.NumIntExp_Dto.to_s.rjust(3, '0')}-#{self.NumIntExp_Ord.to_s.rjust(3, '0')}/#{self.NumIntExp_Ano.to_s.rjust(2, '0')}"
  end
end
