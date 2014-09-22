class Expediente < ActiveRecord::Base
  has_many :movimientos
end
