class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :recipes, :categories_id, :category_id
  end
end
