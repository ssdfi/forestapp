class ActividadTitular < ActiveRecord::Base
  self.table_name = "actividades_titulares"

  belongs_to :actividad
  belongs_to :titular
  belongs_to :especie
  belongs_to :tipo_plantacion

  def superficie_registrada
    @superficie_registrada ||= ActividadPlantacion
      .joins('JOIN plantaciones ON plantaciones.id = actividades_plantaciones.plantacion_id')
      .joins('JOIN especies_plantaciones ON especies_plantaciones.plantacion_id = plantaciones.id')
      .joins('JOIN especies ON especies.id = especies_plantaciones.especie_id')
      .where("actividades_plantaciones.actividad_id = ? and plantaciones.tipo_plantacion_id = ? and plantaciones.titular_id = ? and especies.id = ?",
        actividad.id, tipo_plantacion.id, titular.id, especie.id)
      .sum('actividades_plantaciones.superficie_registrada')
  end
end
