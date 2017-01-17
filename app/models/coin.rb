COIN_STANDARDS = [
  {"name" => :penny,
  "weight" => 2.500,
  "diameter" => 0.750,
  "thickness" => 0.0598
  },
  {
    "name" => :nickel,
    "weight" => 5.000,
    "diameter" => 0.835,
    "thickness" => 0.1625
  },
  {
    "name" => :dime,
    "weight" => 2.268,
    "diameter" => 0.705,
    "thickness" => 0.053
  },
  { "name" => :quarter,
    "weight" => 5.670,
    "diameter" => 0.955,
    "thickness" => 0.069
  }
]

class Coin < ApplicationRecord
  validates_presence_of :weight, :diameter, :thickness

  #I used the attribute feature and increased the quantity for each coin identified, rather than added the actual coin object to inserted_coin because later when I have to calculate the total, it is faster to just take the count of the attribute, rather than to iterate over each coin object, check whether the name matches "dime," "nickel," or "penny" and add to the total from there.
  def dime(user_coins)
    user_coins.dimes += 1
  end

  def nickel(user_coins)
    user_coins.nickels += 1
  end

  def quarter(user_coins)
    user_coins.quarters += 1
  end

  def penny(user_coins)
    user_coins.pennies += 1
  end

  def evaluate_coin_values(user_coins)
      COIN_STANDARDS.each{ |coin|
        if (self.thickness - coin["thickness"]).between?(-0.002, 0.002) && (self.diameter - coin["diameter"]).between?(-0.002, 0.002) && (self.weight - coin["weight"]).between?(-0.002, 0.002)
          send(coin["name"], user_coins)
          break
        end
      }
    end


end
