class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :prep_time
      t.integer :complexity
      t.text :ingredients
      t.text :directions
      t.integer :servings
      t.boolean :grabbed
      t.integer :user_id
      t.integer :categories_id

      t.timestamps
    end
  end
end
