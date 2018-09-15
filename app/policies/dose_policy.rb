class DosePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show
    return true
  end

  def create?
    return true
  end

  def destroy?
    # user_is_owner_or_admin?
    return true
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end

end
