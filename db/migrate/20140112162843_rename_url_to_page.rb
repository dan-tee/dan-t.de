class RenameUrlToPage < ActiveRecord::Migration
  def change
    rename_column :page_views, :url, :page
  end
end
