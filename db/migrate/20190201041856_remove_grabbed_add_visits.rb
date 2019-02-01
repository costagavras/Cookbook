class RemoveGrabbedAddVisits < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :visits, :integer, default: 0
    remove_column :recipes, :grabbed
  end
end
