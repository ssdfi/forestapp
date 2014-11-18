class Titular < ActiveRecord::Base
  has_many :plantaciones
  has_and_belongs_to_many :expedientes_titular, class_name: 'Expediente', source: :expedientes
  has_many :expedientes_plantacion, -> { distinct }, class_name: 'Expediente', through: :plantaciones, source: :expedientes

  def expedientes
    query1 = self.expedientes_titular
    query2 = self.expedientes_plantacion

    sql = Expediente.connection.unprepared_statement {
      "((#{query1.to_sql}) UNION (#{query2.to_sql})) AS expedientes"
    }

    Expediente.from(sql)
  end
end