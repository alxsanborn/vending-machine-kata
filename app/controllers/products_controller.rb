class ProductsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @products = Product.all
  end
end
