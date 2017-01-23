class CoinsController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def edit
    current_order.update(return_coins: false)
    coin = Coin.find(params[:id])
    coin.evaluate_coin_values(current_order.inserted_coin)
    redirect_to root_path
  end
end
