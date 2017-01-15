require_relative 'concerns/actions.rb'
class Order < ApplicationRecord
  has_one :inserted_coin

  include Actions::InsertedCoin
  include Actions::ProductInstance
  extend Actions::ProductClass
  include Actions::ChangeReturn

    def insert_coins
      "INSERT COINS"
    end

    def thank_you
      "THANK YOU"
    end

    def sold_out
      "SOLD OUT"
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

    def user_message(product = nil)
      case
      when self.return_coins == true && self.inserted_coin.total > 0
        return_inserted_coins
      when self.inserted_coin.total == 0
        insert_coins
      when product && self.inserted_coin.total >= product.price && product.quantity == 0
        sold_out
      when product && self.inserted_coin.total >= product.price && product.quantity > 0
          make_change(remainder?(product)) if remainder?(product) > 0
          product.deselect_button
          thank_you
      else
          self.inserted_coin.value = self.inserted_coin.total
          self.inserted_coin.value
       end
     end
end
