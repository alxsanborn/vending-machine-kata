class OrdersController < ApplicationController
  def new
  end

  def create
    @order.inserted_coin.push(InsertedCoin.create)
  end
end
