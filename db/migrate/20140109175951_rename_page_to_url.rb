class RenamePageToUrl < ActiveRecord::Migration
  def change
    rename_column :page_views, :page, :url
  end
end
