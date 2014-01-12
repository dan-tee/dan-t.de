class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.integer :user_id
      t.string :page

      t.timestamps
    end
  end
end
