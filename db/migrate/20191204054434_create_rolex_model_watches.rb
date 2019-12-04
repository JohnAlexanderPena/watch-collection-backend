class CreateRolexModelWatches < ActiveRecord::Migration[6.0]
  def change
    create_table :rolex_model_watches do |t|
      t.string :watch_url
      t.string :description
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end
end
