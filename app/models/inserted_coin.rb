require_relative 'concerns/actions.rb'

class InsertedCoin < ApplicationRecord
  belongs_to :order

  include Actions::InsertedCoin
end
