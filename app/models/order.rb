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

    def return_inserted_coins
      {
      "quarters" => self.quarters.length,
      "dimes" => self.dimes.length,
      "nickels" => self.nickels.length
      }
    end

    def user_message(product = nil)
      case
      when self.return_coins == true && self.total > 0
        return_inserted_coins
      when self.inserted_coin.total == 0
        insert_coins
    #   when product_selected? && self.total >= product_selected?.price && product_selected?.quantity == 0
    #     sold_out
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
