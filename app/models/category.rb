class Category < ActiveRecord::Base
  belongs_to :parent_category, class_name: 'Category'
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy
  has_many :products

  scope :root_categories, -> { where(parent_id: nil) }
end
