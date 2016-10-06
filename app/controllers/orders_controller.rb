class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.create(order_params)

    OrderMailer.pdf_email(@order, ENV['MAIN_EMAIL'], params[:order][:pdf]).deliver_later
    render 'show'
  end

  private

  def order_params
    params.require(:order)
          .permit(:comment,
                  order_items_attributes: [:product_id, :quantity, :price])
  end
end
