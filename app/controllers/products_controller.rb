class ProductsController < ApplicationController
  include Cacheable

  def index
    @products = Product.order(:name).by_category(params[:category]).search(params[:value], params[:type], nil)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.order(:name).search(params[:value], params[:type])

    render 'index'
  end
end
