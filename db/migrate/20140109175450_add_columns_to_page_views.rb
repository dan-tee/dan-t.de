class AddColumnsToPageViews < ActiveRecord::Migration
  def change
    add_column :page_views, :method, :string
    add_column :page_views, :format, :string
  end
end
