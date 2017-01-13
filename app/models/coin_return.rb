class CoinReturn < ApplicationRecord
  has_many :dimes
  has_many :nickels
  has_many :quarters
  belongs_to :user_total_coin
end
