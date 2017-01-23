class ProductsController < ApplicationController
  def new
  end

  def create
  end

  def index
    current_order
    @products = Product.all
    @coins = Coin.all
  end

  def show
  end

  def edit
  end
end
