class ProductsController < ApplicationController
  include Cacheable

  def index
    @products = Product
      .order(:name)
      .by_category(params[:category])
      .exact_search(params[:value], params[:type])
      .page(params[:page])
  end

  def show
    @product = Product.find_by(id: params[:id]) || Product.find_by(code: params[:id])
  end

  def search
    @products = Product.order(:name).by_category(params[:category]).exact_search(params[:value], 'name').limit(7)

    render 'index'
  end
end
