class CreateWatchBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :watch_brands do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
