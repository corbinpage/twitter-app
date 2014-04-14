class CreateWordTypes < ActiveRecord::Migration
  def change
    create_table :word_types do |t|
      t.string   :text, index: true

      t.timestamps
    end
  end
end
