class SessionsController < ApplicationController
  def new
  end

  def create
    order = Order.create(inserted_coin: InsertedCoin.create)
    session[:order_id] = order.id
  end
end
