class UpdateDepartamentoInPlantaciones < ActiveRecord::Migration
  def up
    execute "
      UPDATE plantaciones
      SET departamento_id = (
        SELECT departamentos.id
        FROM tmp_unificados
        JOIN departamentos
          ON departamentos.zona_id = plantaciones.zona_id
            AND departamentos.codigo = substring(tmp_unificados.numero_interno from 8 for 3)
        WHERE tmp_unificados.id = plantaciones.unificado_id
      )
      WHERE plantaciones.unificado_id IS NOT NULL
        AND plantaciones.departamento_id IS NULL
    "
  end

  def down
    execute "
      UPDATE plantaciones
      SET departamento_id = NULL
      WHERE plantaciones.unificado_id IS NOT NULL
    "
  end
end
