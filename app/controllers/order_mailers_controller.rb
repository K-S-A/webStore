class OrderMailersController < ApplicationController

  def create
    order = Order.find(params[:order_id])
    target = params[:email]
    pdf = params[:order_mailer][:order][:pdf]

    OrderMailer.pdf_email(order, target, pdf).deliver_later
    render nothing: true
  end

end