class BaseGeometrica < ActiveRecord::Base
  self.table_name = "bases_geometricas"
  has_many :plantaciones, :foreign_key => "base_geometrica_id"
end
