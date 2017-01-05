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
end
