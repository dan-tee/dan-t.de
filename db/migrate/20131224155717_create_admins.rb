class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :admin_token
      t.string :ip

      t.timestamps
    end

    add_index :admins, :admin_token
  end
end
