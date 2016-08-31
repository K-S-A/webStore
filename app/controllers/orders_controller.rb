class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    @order = current_user.orders.create(order_params)

    render 'show'
  end

  private

  def order_params
    params.require(:order)
          .permit(:stock_number,
                  :comment,
                  order_items_attributes: [:product_id, :quantity, :price])
  end
end
