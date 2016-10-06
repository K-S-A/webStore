class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  accepts_nested_attributes_for :order_items

  default_scope { includes(order_items: :product) }

  before_validation :set_stock_number

  def total
    self.order_items.includes(:product).map(&:total).sum
  end

  private

  def set_stock_number
    self.stock_number = Order.maximum(:stock_number).next
  end

end
