class Titular < ActiveRecord::Base
  has_many :plantaciones
  has_and_belongs_to_many :expedientes_titular, class_name: 'Expediente', source: :expedientes
  has_many :expedientes_plantacion, -> { distinct }, class_name: 'Expediente', through: :plantaciones, source: :expedientes

  ##
  # Devuelve los expedientes relacionados con el titular, ya sea los expedientes directos como los expedientes agrupados
  # que incluyan una plantación perteneciente al titular
  def expedientes
    query1 = self.expedientes_titular
    query2 = self.expedientes_plantacion

    sql = Expediente.connection.unprepared_statement {
      "((#{query1.to_sql}) UNION (#{query2.to_sql})) AS expedientes"
    }

    Expediente.from(sql)
  end

  ##
  # Busca los titulares que coincidan con los atributos definidos en el objeto Titular pasado como parámetro
  def self.search(titular)
    titulares = all
    if titular
      titulares = where("nombre ILIKE ?", "%#{titular.nombre}%") unless titular.nombre.blank?
      titulares = titulares.where("dni ILIKE ?", "%#{titular.dni}%") unless titular.dni.blank?
      titulares = titulares.where("cuit ILIKE ?", "%#{titular.cuit}%") unless titular.cuit.blank?
      titulares = titulares.distinct
    end
    titulares.order(:nombre)
  end
end
