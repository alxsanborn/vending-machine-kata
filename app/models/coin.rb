require 'pry'

class Coin < ApplicationRecord
  validates_presence_of :weight, :diameter, :thickness
end
