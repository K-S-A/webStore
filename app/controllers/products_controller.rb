class ProductsController < ApplicationController
  def index
    @products = Product.search(params[:name], [], false)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.exact_search(params[:name])

    if @products.size < Product::MAX_SEARCH_COUNT
      @products += Product.search(params[:name], @products.map(&:id))
    end

    render 'index'
  end
end
