class UserTotalCoin < ApplicationRecord
  has_many :coins
  has_many :dimes
  has_many :nickels

  def dime
    self.dimes << Dime.new
  end

  def nickel
    self.nickels << Nickel.new
  end
end
