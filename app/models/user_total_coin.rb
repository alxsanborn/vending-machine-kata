class UserTotalCoin < ApplicationRecord
  has_many :coins
  has_many :dimes

  def dime
    self.dimes << Dime.new
  end
end
