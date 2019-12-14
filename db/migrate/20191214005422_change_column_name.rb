class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :rolex_model_watches, :name, :rolex_model
  end
end
