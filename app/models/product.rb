class Product < ActiveRecord::Base

  scope :search, -> (name) { where('name ILIKE ?', "%#{name}%") }
end
