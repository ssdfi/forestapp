class ExpedientePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.editor?
        scope.all
      else
        scope.joins(:movimientos).where("movimientos.fecha_salida IS NOT NULL")
      end
    end
  end
end
