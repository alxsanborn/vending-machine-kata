class OrdersController < ApplicationController
  def new
    delete_order
    redirect_to root_path
  end

  def create
  end

  def show
  end

  def edit
    current_order.update(return_coins: true)
    Coin.all_valid_coins = []
    redirect_to root_path
  end
end
