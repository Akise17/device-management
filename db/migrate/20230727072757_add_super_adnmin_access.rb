class AddSuperAdnminAccess < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :is_superadmin, :boolean, default: false
  end
end
