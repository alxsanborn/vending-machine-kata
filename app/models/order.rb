require_relative 'concerns/actions.rb'

class Order < ApplicationRecord
  has_one :inserted_coin

  include Actions::InsertedCoins
  include Actions::ProductInstance
  extend Actions::ProductClass
  include Actions::ChangeReturn

    def coin_return(product=nil)
      case
      when self.return_coins == true && self.inserted_coin.total > 0
        product.deselect_button if product
        return_inserted_coins
      when self.inserted_coin.pennies > 0
        return_pennies
      when product && self.inserted_coin.total >= product.price && product.quantity > 0
        make_change(remainder?(product)) if remainder?(product) > 0
      end
    end

    def user_message(product = nil)
      case
      when self.return_coins == true && enough_change?
        reset_coin_amounts
        insert_coins
      when self.return_coins == true
        reset_coin_amounts
        exact_change_only
      when self.inserted_coin.total == 0 && enough_change?
        reset_pennies
        insert_coins
      when self.inserted_coin.total == 0
        reset_pennies
        exact_change_only
      when product && self.inserted_coin.total >= product.price && product.quantity == 0
        product.deselect_button
        sold_out
      when product && self.inserted_coin.total >= product.price && product.quantity > 0
        reset_visible_coins
        add_quarters_to_machine
        add_dimes_to_machine
        add_nickels_to_machine
        product.decrease_product_quantity
        product.deselect_button
        purchase
        thank_you
      else
        reset_pennies
        self.inserted_coin.value = self.inserted_coin.total
        '%.2f' % self.inserted_coin.value
       end
     end

     private
     def reset_visible_coins
      Coin.all_valid_coins = []
     end

     def purchase
      self.update(purchased: true)
     end

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

     def reset_coin_amounts
       self.inserted_coin.update(quarters: 0, dimes: 0, nickels: 0, pennies: 0)
     end

     def enough_change?
       true if InsertedCoin.machine_quarters >= 1 && InsertedCoin.machine_dimes >=1 && InsertedCoin.machine_nickels >= 1
     end

     def add_quarters_to_machine
       InsertedCoin.machine_quarters += self.inserted_coin.quarters
     end

     def add_dimes_to_machine
       InsertedCoin.machine_dimes += self.inserted_coin.dimes
     end

     def add_nickels_to_machine
       InsertedCoin.machine_nickels += self.inserted_coin.nickels
     end

     def return_pennies
       {"pennies" => self.inserted_coin.pennies}
     end

     def reset_pennies
       self.inserted_coin.update(pennies: 0)
     end
   end
