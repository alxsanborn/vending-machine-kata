class OrdersController < ApplicationController
  def new
    delete_order
    Product.product_selected?.deselect_button
    redirect_to root_path
  end

  def edit
    current_order.update(return_coins: true)
    Coin.all_valid_coins = []
    redirect_to root_path
  end
end
