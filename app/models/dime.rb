class Dime < ApplicationRecord
  belongs_to :user_total_coin, optional: true
end
