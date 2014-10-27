class UsoForestal < ActiveRecord::Base
  self.table_name = "usos_forestales"
  has_many :plantaciones, :foreign_key => "uso_forestal_id"
end
