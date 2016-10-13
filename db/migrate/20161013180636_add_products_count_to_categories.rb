class AddProductsCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :products_count, :integer, null: false, default: 0
  end
end
