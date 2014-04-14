class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :text
      t.references :word_type

      t.timestamps
    end
  end
end
