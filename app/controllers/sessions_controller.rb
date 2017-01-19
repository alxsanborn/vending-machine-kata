class SessionsController < ApplicationController
  def new
  end

  def create
    order = Order.create
    session[:order_id] = order.id
  end
end
