class MovimientoPolicy < ApplicationPolicy

  def report?
    user.editor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
