class UsoAnterior < ActiveRecord::Base
  self.table_name = "usos_anteriores"
  has_many :plantaciones, :foreign_key => "uso_anterior_id"
end
