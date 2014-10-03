class Expediente < ActiveRecord::Base
  has_many :movimientos
  attr_reader :incompleto

  def incompleto=(value)
    @incompleto = (value == "true") unless value.blank?
  end
end
