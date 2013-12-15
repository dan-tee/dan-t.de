class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
