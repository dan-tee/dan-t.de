class AddArchivedToPrivateMessages < ActiveRecord::Migration
  def change
    add_column :private_messages, :archived, :boolean, default: 0
  end
end
