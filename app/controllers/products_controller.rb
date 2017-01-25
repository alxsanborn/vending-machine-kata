#I used Ruby because it's the language I'm most comfortable in, but after doing this project, I'm not sure Rails was the best framework to use. I probably should have just done a CLI, but by the time I realized this, it was too late because I had already done so much work on the front end. Rails favors convention over configuration. This particular project had a lot of custom logic that probably would have been a better fit for a framework like Node.js that favors configuration over convention.
class ProductsController < ApplicationController
  def new
  end

  def create
  end

  def index
    current_order #associates session with instance of order
    @products = Product.all
    @coins = Coin.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    params["id"] == ":id" ? @product = Product.product_selected? : @product = Product.find(params[:id])
    @product.selected == false ? @product.select_button : @product.deselect_button
    redirect_to root_path
  end
end
