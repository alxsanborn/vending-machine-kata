require 'pry'

COIN_STANDARDS = [
  {"name" => "penny",
  "weight" => 2.500,
  "diameter" => 0.750,
  "thickness" => 0.0598
  },
  {
    "name" => "nickel",
    "weight" => 5.000,
    "diameter" => 0.835,
    "thickness" => 0.1625
  },
  {
    "name" => "dime",
    "weight" => 2.268,
    "diameter" => 0.705,
    "thickness" => 0.053
  },
  { "name" => "quarter",
    "weight" => 5.670,
    "diameter" => 0.955,
    "thickness" => 0.069
  }
]

class Coin < ApplicationRecord
  validates_presence_of :weight, :diameter, :thickness

  def evaluate_coin_values
      COIN_STANDARDS.each{ |coin|
        if (self.thickness - coin["thickness"]).between?(-0.002, 0.002) && (self.diameter - coin["diameter"]).between?(-0.002, 0.002) && (self.weight - coin["weight"]).between?(-0.002, 0.002)
          return coin["name"]
          break
        end
      }
    end

end
