json.(order_item, :id, :product_id, :quantity, :price, :created_at)
json.product do
  json.partial! 'products/product', product: order_item.product
end
