require_relative 'concerns/actions.rb'

class InsertedCoin < ApplicationRecord
  has_many :dimes
  has_many :nickels
  has_many :quarters
  belongs_to :order

  include Actions::InsertedCoin

  #   def sold_out
  #     "SOLD OUT"
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
