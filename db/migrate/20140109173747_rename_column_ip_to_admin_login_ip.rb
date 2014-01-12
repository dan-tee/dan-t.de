class RenameColumnIpToAdminLoginIp < ActiveRecord::Migration
  def change
    rename_column :users, :ip, :admin_login_ip
  end
end
