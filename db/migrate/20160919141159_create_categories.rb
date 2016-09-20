class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.belongs_to :parent, index: true

      t.timestamps null: false
    end

    add_foreign_key :categories, :categories, column: :parent_id
  end
end
