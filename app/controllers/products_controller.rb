class ProductsController < ApplicationController
  def new
  end

  def create
  end

  def index
    current_order
    @products = Product.all
  end

  def show
  end
end
