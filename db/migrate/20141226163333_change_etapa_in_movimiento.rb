class ChangeEtapaInMovimiento < ActiveRecord::Migration
  def up
    execute "update movimientos set etapa = null where etapa IS NOT NULL AND etapa !~ E'^\\\\d{4}$';"
    change_column :movimientos, :etapa, "integer USING (etapa::integer)"
  end

  def down
    change_column :movimientos, :etapa, :string
  end
end
