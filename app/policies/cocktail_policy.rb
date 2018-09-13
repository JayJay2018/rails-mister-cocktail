class CocktailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # anyone can view everything
      scope.all

      # user can only see his cocktails
      # scope.where(user: user)
    end
  end

  def show?
    return true
  end

  def index?
    return true
  end

  def create?
    return true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end
end
