class AddingIndexes < ActiveRecord::Migration
  def change
    add_index :word_types, :text
    add_index :tweets, :created_at
    add_index :words, :text
  end
end
