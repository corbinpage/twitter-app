class CreateScans < ActiveRecord::Migration
  def change
    create_table  :scans do |t|
      t.integer   :score
      t.string    :error
      t.float     :average_sentiment

      t.timestamps
    end
  end
end
