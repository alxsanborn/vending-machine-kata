class Coin < ApplicationRecord
  validates_presence_of :weight, :diameter
end
