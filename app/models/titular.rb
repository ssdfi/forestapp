class Titular < ActiveRecord::Base
  has_many :plantaciones
  has_and_belongs_to_many :expedientes_titular, class_name: 'Expediente', source: :expedientes
  has_many :expedientes_plantacion, -> { distinct }, class_name: 'Expediente', through: :plantaciones, source: :expedientes
  has_many :actividades_titulares, class_name: 'ActividadTitular'

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
  end

  ##
  # Normaliza el nombre según un criterio específico
  # Elimina tildes, comas, apóstrofes y pone en mayúsculas la primer letra de cada palabra
  def self.normalize_nombre(nombre)
    I18n.transliterate(nombre).delete(',').titleize
  end

  ##
  # Busca el titular y si no lo encuentra, lo crea
  def self.find_or_create(nombre, dni, cuit)
    nombre = normalize_nombre(nombre)
    dni = dni != '0' ? dni : nil
    cuit = cuit != '0' ? cuit : nil

    if dni
      titular = find_by_dni(dni)
      if titular
        titular.update(nombre: nombre)
        titular.update(cuit: cuit) if cuit
        return titular
      end
    end

    if cuit
      titular = find_by_cuit(cuit)
      if titular
        titular.update(nombre: nombre)
        titular.update(dni: dni) if dni
        return titular
      end
    end

    titular = find_by_nombre(nombre)
    if titular
      titular.update(dni: dni) if dni
      titular.update(cuit: cuit) if cuit
      return titular
    end

    titular = create!(nombre: nombre, dni: dni, cuit: cuit)
    return titular
  end
end
