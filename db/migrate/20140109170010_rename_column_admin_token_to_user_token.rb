class RenameColumnAdminTokenToUserToken < ActiveRecord::Migration
  def change
    rename_column :users, :admin_token, :id_token
  end
end
