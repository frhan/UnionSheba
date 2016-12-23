class SetDeafultAdminRoleToAllUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      role = Role.find_by_role_name('admin')
      #logger.debug('role name', role.role_name)
      user.role = role
      user.save
    end

  end
end
