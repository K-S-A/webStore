class AddRootCategoryToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :root_category, references: :categories, index: true
    add_foreign_key :products, :categories, column: :root_category_id
  end
end
