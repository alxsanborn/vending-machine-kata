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
    @product = Product.find(params[:id])
  end

  def edit
    if params["id"] == ":id"
      @product = Product.product_selected?
    else @product = Product.find(params[:id])
    end

    if @product.selected == false
      @product.select_button
    else
      @product.deselect_button
    end
    redirect_to root_path
  end
end
