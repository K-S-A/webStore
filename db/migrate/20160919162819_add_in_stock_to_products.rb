class AddInStockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :in_stock, :integer
  end
end
