class Order < ApplicationRecord
  has_one :inserted_coin
  has_one :coin_return
end
