class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.belongs_to :user
      t.string :filepath

      t.timestamps
    end
  end
end
