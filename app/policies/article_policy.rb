class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def index?
      true
    end

    def create?
      user.admin? || user.rh? # Autorise admin ou rh à créer une catégorie
    end
  end
end
