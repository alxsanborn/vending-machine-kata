require_relative 'concerns/actions.rb'

class InsertedCoin < ApplicationRecord
  has_many :dimes
  has_many :nickels
  has_many :quarters
  belongs_to :order

  include Actions::InsertedCoin

end
