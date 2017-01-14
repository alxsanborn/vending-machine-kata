require 'rails_helper'

RSpec.describe Product, type: :model do

  let (:coffee) {Product.create(name: "coffee", price: 1.00)}

  it 'can create a new product with name and price' do
    expect(coffee).to be_valid
  end

  it 'selected attribute defaults to false' do
    expect(coffee.selected).to be(false)
  end

  it 'cannot be created without name' do
    product_1 = Product.create(price: 0.45)
    expect(product_1).to_not be_valid
  end

  it 'cannot be created without price' do
    free_cheetos = Product.create(name: 'cheetos')
    expect(free_cheetos).to_not be_valid
  end

  it 'user can select a product' do
    coffee.select_button
    expect(coffee.selected).to be(true)
  end

  it 'quantity defaults to 0' do
    expect(coffee.quantity).to eq(0)
  end

  it 'can detect which products are selected' do
    coffee.select_button
    expect(Product.product_selected?).to eq(coffee)
  end

  it 'can deselect a product' do
    coffee.update(selected: true)
    coffee.deselect_button
    expect(coffee.selected).to be(false)
  end
end
