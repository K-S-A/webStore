json.(category, :id, :name)
json.subcategories do
  json.array! category.subcategories, partial: 'category', as: :category
end
