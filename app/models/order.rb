require_relative 'concerns/actions.rb'

class Order < ApplicationRecord
  has_one :inserted_coin

  include Actions::InsertedCoins
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

    def exact_change_only
      "EXACT CHANGE ONLY"
    end

    def return_coins_button
      self.update(return_coins: true)
    end

    def return_inserted_coins
      {
      "quarters" => self.inserted_coin.quarters,
      "dimes" => self.inserted_coin.dimes,
      "nickels" => self.inserted_coin.nickels
      }
    end

    def enough_change?
      true if InsertedCoin.machine_quarters >= 2 && InsertedCoin.machine_dimes >=2 && InsertedCoin.machine_nickels >= 2
    end

    def user_message(product = nil)
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
