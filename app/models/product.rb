require_relative 'concerns/actions.rb'
class Product < ApplicationRecord
  validates_presence_of :name, :price

  has_attached_file :product_image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/

  extend Actions::ProductClass
  include Actions::ProductInstance

end
