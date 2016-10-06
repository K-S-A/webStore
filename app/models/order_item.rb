class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  delegate :name, :scu, :img_link, :code, to: :product

  def total
    self.quantity * self.price
  end
end
