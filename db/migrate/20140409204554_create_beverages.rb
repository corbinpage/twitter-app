class CreateBeverages < ActiveRecord::Migration
  def change
    create_table :beverages do |t|
      t.string :text

      t.timestamps
    end
  end
end
