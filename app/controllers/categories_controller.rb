class CategoriesController < ApplicationController
  def index
    @categories = Category.root_categories.includes(subcategories: [subcategories: [subcategories: :subcategories]])
  end

  def show
    @products = Product.where(category_id: params[:id]).order(:name).page(params[:page])

    render 'products/index'
  end
end
