class Pago < ActiveRecord::Base
  belongs_to :actividad
  has_many :titulares, class_name: 'PagoTitular'
end
