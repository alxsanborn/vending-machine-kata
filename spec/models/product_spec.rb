require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'can create a new product with name and price' do
    coffee = Product.create(name: "coffee", price: 1.00)
    expect(coffee).to be_valid
  end
end
