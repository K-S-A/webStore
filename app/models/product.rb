class Product < ActiveRecord::Base
  # scope :search, -> (name) { order(:name).where('name ILIKE ?', "%#{name}%") }
  scope :search, -> (name) do
    name = name.split(/[ \-,._]+/).map { |n| "%#{n}%" }
    order(:name).where('name ILIKE ANY ( array[?] )', name)
  end
end
