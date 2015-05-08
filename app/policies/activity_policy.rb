class ActivityPolicy < ApplicationPolicy
  def submit?
    !!user
  end
end
