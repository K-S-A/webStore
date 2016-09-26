class ProductsController < ApplicationController
  include Cacheable

  def index
    @products = Product
      .order(:name)
      .by_category(params[:category])
      .approx_search(params[:value])
      .page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.order(:name).by_category(params[:category]).approx_search(params[:value]).page(params[:page])

    render 'index'
  end
end
