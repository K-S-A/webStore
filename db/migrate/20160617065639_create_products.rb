class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :img_link
      t.string :code
      t.string :category
      t.decimal :price, precision: 8, scale: 2
      t.string :scu

      t.timestamps null: false
    end
  end
end
