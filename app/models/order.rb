class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  default_scope { includes(order_items: :product) }
end
