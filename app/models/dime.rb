class Dime < ApplicationRecord
  belongs_to :user_total_coin, optional: true
  belongs_to :coin_return, optional: true
end
