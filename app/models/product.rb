require_relative 'concerns/actions.rb'
class Product < ApplicationRecord
  validates_presence_of :name, :price

  extend Actions::ProductClass
  include Actions::ProductInstance


  # def self.product_selected?
  #   Product.all.select{|product| product.selected == true}.first
  # end
end
