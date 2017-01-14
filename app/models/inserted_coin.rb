require_relative 'concerns/actions.rb'

class InsertedCoin < ApplicationRecord
  has_many :dimes
  has_many :nickels
  has_many :quarters
  belongs_to :order

  include Actions::InsertedCoin

  #   def dispense_item
  #     "THANK YOU"
  #   end
  #
  #   def sold_out
  #     "SOLD OUT"
  #   end
  #
  #   def product_selected?
  #     Product.all.select{|product| product.selected == true}[0]
  #   end
  #
  #   def make_change_quarters(remainder)
  #     while remainder >= 0.25
  #       remainder -= 0.25
  #       self.coin_return.quarters.push(Quarter.create)
  #       if remainder < 0.25
  #         break
  #       end
  #     end
  #     remainder.round(2)
  #   end
  #
  #   def make_change_dimes(remainder)
  #     while remainder >= 0.10
  #       remainder -= 0.10
  #       self.coin_return.dimes.push(Dime.create)
  #       if remainder < 0.10
  #         break
  #       end
  #     end
  #     remainder.round(2)
  #   end
  #
  #   def make_change_nickels
  #     self.coin_return.nickels.push(Nickel.create)
  #   end
  #
  #   def make_change(remainder)
  #     remainder = make_change_quarters(remainder)
  #     remainder = make_change_dimes(remainder)
  #     make_change_nickels if remainder && remainder > 0
  #     return {
  #       "quarters" => self.coin_return.quarters.length,
  #       "dimes" => self.coin_return.dimes.length,
  #       "nickels" => self.coin_return.nickels.length
  #     }
  #   end
  #
  #   def remainder?
  #     self.total - product_selected?.price
  #   end
  #
  #   def return_inserted_coins
  #     {
  #     "quarters" => self.quarters.length,
  #     "dimes" => self.dimes.length,
  #     "nickels" => self.nickels.length
  #     }
  #   end
  #

end
