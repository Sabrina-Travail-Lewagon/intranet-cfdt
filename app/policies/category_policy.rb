class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where(user:user)
    end
  end

  def index?
    user.admin? || user.rh? # Autorise admin ou rh à créer une catégorie
  end

  def show?
    true
  end

  def create?
    user.admin? || user.rh? # Autorise admin ou rh à créer une catégorie
  end

  def update?
    user.admin? || user.rh? # Autorise admin ou rh à mettre à jour une catégorie
  end

  def destroy?
    user.admin? || user.rh? # Autorise admin ou rh à supprimer une catégorie
  end
end
