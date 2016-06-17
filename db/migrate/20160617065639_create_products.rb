class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :img_link

      t.timestamps null: false
    end
  end
end
