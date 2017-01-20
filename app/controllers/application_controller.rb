class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

 def current_order
   session[:order_id] ||= Order.create(inserted_coin: InsertedCoin.create)
 end
end
