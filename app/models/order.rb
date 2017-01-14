require_relative 'concerns/actions.rb'
class Order < ApplicationRecord
  has_one :inserted_coin
  has_one :coin_return

  include Actions::InsertedCoin

    def insert_coins
      "INSERT COINS"
    end

    def user_message
      case
    #   when self.return_coins == true && self.total > 0
    #     return_inserted_coins
      when self.inserted_coin.total == 0
        insert_coins
    #   when product_selected? && self.total >= product_selected?.price && product_selected?.quantity == 0
    #     sold_out
    #   when product_selected? && self.total >= product_selected?.price && product_selected?.quantity > 0
    #     make_change(remainder?) if remainder? > 0
    #     dispense_item
    #   else
    #       value_will_change!
    #       self.value = self.total
    #       self.value
       end
     end
end
