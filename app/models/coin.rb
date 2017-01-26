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
  has_attached_file :coin_image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :coin_image, content_type: /\Aimage\/.*\z/

  @@all_valid_coins = []

  def self.all_valid_coins=(all_valid_coins)
    @@all_valid_coins = all_valid_coins
  end

  def self.all_valid_coins
    @@all_valid_coins
  end

  def dime(user_coins)
    user_coins.update(dimes: user_coins.dimes + 1)
    @@all_valid_coins.push(self)
  end

  def nickel(user_coins)
    user_coins.update(nickels: user_coins.nickels + 1)
    @@all_valid_coins.push(self)
  end

  def quarter(user_coins)
    user_coins.update(quarters: user_coins.quarters + 1)
    @@all_valid_coins.push(self)
  end

  def penny(user_coins)
    user_coins.update(pennies: user_coins.pennies + 1)
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
