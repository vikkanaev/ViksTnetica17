class Api::V1::ProfilesController < Api::V1::BaseController
  def me
    respond_with current_resource_owner
  end

  def other_users_list
    respond_with(User.where.not(id: current_resource_owner.id))
  end
end
