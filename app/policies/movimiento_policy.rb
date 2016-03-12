class MovimientoPolicy < ApplicationPolicy

  def report?
    user.editor?
  end

  def ef_report?
    user.editor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
