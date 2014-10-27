class EstratoDesarrollo < ActiveRecord::Base
  self.table_name = "estratos_desarrollo"
  has_many :plantaciones, :foreign_key => "estrato_desarrollo_id"
end