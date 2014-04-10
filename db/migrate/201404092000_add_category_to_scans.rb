class AddCategoryToScans < ActiveRecord::Migration
  def change
    add_column :scans, :category, :string
    add_index :scans, :category
  end
end