require_relative 'concerns/actions.rb'
require_relative 'concerns/total_change.rb'

class Order < ApplicationRecord
  has_one :inserted_coin

  include Actions::InsertedCoin
  include Actions::ProductInstance
  extend Actions::ProductClass
  include Actions::ChangeReturn
  include TotalChange

    def insert_coins
      "INSERT COINS"
    end

    def thank_you
      "THANK YOU"
    end

    def sold_out
      "SOLD OUT"
    end

    def exact_change_only
      "EXACT CHANGE ONLY"
    end

    def return_coins_button
      self.update(return_coins: true)
    end

    def return_inserted_coins
      {
      "quarters" => self.inserted_coin.quarters.length,
      "dimes" => self.inserted_coin.dimes.length,
      "nickels" => self.inserted_coin.nickels.length
      }
    end

    def enough_change?
      true if $total_change["quarters"] >= 2 && $total_change["dimes"] >=2 && $total_change["nickels"] >= 2
    end

    def user_message(product = nil)
      binding.pry
      case
      when self.return_coins == true && self.inserted_coin.total > 0
        return_inserted_coins
      when self.inserted_coin.total == 0 && enough_change?
        insert_coins
      when self.inserted_coin.total == 0
        exact_change_only
      when product && self.inserted_coin.total >= product.price && product.quantity == 0
        sold_out
      when product && self.inserted_coin.total >= product.price && product.quantity > 0
          make_change(remainder?(product)) if remainder?(product) > 0
          product.decrease_product_quantity
          product.deselect_button
          thank_you
      else
          self.inserted_coin.value = self.inserted_coin.total
          self.inserted_coin.value
       end
     end
end
