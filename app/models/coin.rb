require 'pry'

class Coin < ApplicationRecord
  validates_presence_of :weight, :diameter, :thickness
  belongs_to :user_total_coin, optional: true
end
