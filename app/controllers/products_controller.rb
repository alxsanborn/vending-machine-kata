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

  def edit
    product = Product.find(params[:id])
    product.select_button
    redirect_to root_path
  end
end
