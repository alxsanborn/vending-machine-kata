require_relative 'concerns/actions.rb'
class Product < ApplicationRecord
  validates_presence_of :name, :price

  include Actions::Products
end
