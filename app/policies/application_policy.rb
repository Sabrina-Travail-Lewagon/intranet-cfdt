# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user&.user? || user&.admin? || user&.rh?
  end

  def show?
    user.admin? || user.rh?
  end

  def create?
    user.admin? || user.rh?
  end

  def new?
    create?
  end

  def update?
    user.admin? || user.rh?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? # Autorise admin ou rh à supprimer une catégorie
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
