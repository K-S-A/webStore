class ProductsController < ApplicationController
  include Cacheable

  def index
    @products = Product.search(params[:name], nil)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.search(params[:name])

    render 'index'
  end
end
