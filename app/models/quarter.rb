class Quarter < ApplicationRecord
  belongs_to :inserted_coin, optional: true
end
