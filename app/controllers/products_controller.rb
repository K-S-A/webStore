class ProductsController < ApplicationController
  def index
    @products = Product.search(params[:name])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.search(params[:name]).limit(8)

    render 'index'
  end
end
