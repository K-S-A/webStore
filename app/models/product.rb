class Product < ActiveRecord::Base

  scope :search, -> (name) { order(:name).where('name ILIKE ?', "%#{name}%") }
end
