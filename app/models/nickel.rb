class Nickel < ApplicationRecord
  belongs_to :inserted_coin, optional: true
end
