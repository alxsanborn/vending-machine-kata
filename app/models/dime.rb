class Dime < ApplicationRecord
  belongs_to :inserted_coin, optional: true
end
