class CoinsController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def edit
    if current_order.return_coins == true
      current_order.update(return_coins: false)
      current_order.reset_coin_amounts
    end
    coin = Coin.find(params[:id])
    coin.evaluate_coin_values(current_order.inserted_coin)
    redirect_to root_path
  end
end
