class PlantacionPolicy < ApplicationPolicy

  def replace?
    user.editor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
