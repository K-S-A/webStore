json.(order, :id, :stock_number, :comment, :created_at, :updated_at)
json.order_items do
  json.array! order.order_items, partial: 'order_items/order_item', as: :order_item
end
json.user do
  json.partial! 'users/user', user: order.user
end