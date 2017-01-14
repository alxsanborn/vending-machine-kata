class Dime < ApplicationRecord
  belongs_to :inserted_coin, optional: true
  belongs_to :coin_return, optional: true
end
