json.(category, :id, :name, :products_count)
json.subcategories do
  json.array! category.subcategories, partial: 'category', as: :category
end
