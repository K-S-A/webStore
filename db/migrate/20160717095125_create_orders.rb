class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :stock_number

      t.timestamps null: false
    end
    add_index :orders, :stock_number, unique: true
  end
end
