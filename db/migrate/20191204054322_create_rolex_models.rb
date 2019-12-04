class CreateRolexModels < ActiveRecord::Migration[6.0]
  def change
    create_table :rolex_models do |t|
      t.string :rolex_model
      t.string :rolex_url
      t.string :image_url

      t.timestamps
    end
  end
end
