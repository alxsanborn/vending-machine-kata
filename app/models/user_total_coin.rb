class UserTotalCoin < ApplicationRecord
  has_many :coins

  def total
  ((self.dimes.length*0.1) + (self.nickels.length*0.05) + (self.quarters.length*0.25)).round(2)
end
end
