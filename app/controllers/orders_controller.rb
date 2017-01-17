class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    if @order.save
      @order.inserted_coin.push(InsertedCoin.create)
    else
      render :new
    end
  end  
end
