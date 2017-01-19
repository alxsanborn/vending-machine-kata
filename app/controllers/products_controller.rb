class ProductsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @products = Product.all
  end

  def show
  end
end
