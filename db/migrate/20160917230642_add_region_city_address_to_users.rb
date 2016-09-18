class AddRegionCityAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :region, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :zipcode, :string
    add_column :users, :phone, :string
  end
end
