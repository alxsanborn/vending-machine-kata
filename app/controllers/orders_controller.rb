class OrdersController < ApplicationController
  def new
  end

  def create
    @order.inserted_coin.push(InsertedCoin.create)
    @inserted_coins = @order.inserted_coin
  end
end
