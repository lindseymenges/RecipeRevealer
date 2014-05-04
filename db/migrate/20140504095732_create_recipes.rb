class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.belongs_to :user
      t.string :name
      t.string :ingredients
      t.string :directions
    end
  end
end
