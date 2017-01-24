class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

 def start_order
   session[:order_id] ||= Order.create(inserted_coin: InsertedCoin.create)
 end

 def current_order
   Order.find(start_order["id"])
 end

 def delete_order
   session[:order_id] = nil
 end
end
