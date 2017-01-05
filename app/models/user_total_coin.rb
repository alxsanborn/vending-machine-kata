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

class UserTotalCoin < ApplicationRecord
  has_many :coins
  has_many :dimes
  has_many :nickels
  has_many :quarters

  def dime
    self.dimes << Dime.new
  end

  def nickel
    self.nickels << Nickel.new
  end

  def quarter
    self.quarters << Quarter.new
  end

  def evaluate_coin_values(inserted_coin)
      COIN_STANDARDS.each{ |coin|
        if (inserted_coin.thickness - coin["thickness"]).between?(-0.002, 0.002) && (inserted_coin.diameter - coin["diameter"]).between?(-0.002, 0.002) && (inserted_coin.weight - coin["weight"]).between?(-0.002, 0.002)
          self.send(coin["name"])
          break
        end
      }
    end
end
