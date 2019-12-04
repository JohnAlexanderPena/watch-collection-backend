class CreateBrandWatches < ActiveRecord::Migration[6.0]
  def change
    create_table :brand_watches do |t|
      t.string :model
      t.string :image_url

      t.timestamps
    end
  end
end
