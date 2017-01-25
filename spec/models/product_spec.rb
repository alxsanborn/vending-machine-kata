require 'rails_helper'

RSpec.describe Product, type: :model do

  let (:cola) {Product.create(name: "cola", price: 1.00)}

  context 'validations' do
    it 'can create a new product with name and price' do
      expect(cola).to be_valid
    end

    it 'cannot be created without name' do
      product_1 = Product.create(price: 0.45)
      expect(product_1).to_not be_valid
    end

    it 'cannot be created without price' do
      free_cheetos = Product.create(name: 'cheetos')
      expect(free_cheetos).to_not be_valid
    end
  end

  context 'default values' do
    it 'selected attribute defaults to false' do
      expect(cola.selected).to be(false)
    end

    it 'quantity defaults to 0' do
      expect(cola.quantity).to eq(0)
    end
  end

  describe '#select_button' do
    it 'user can select a product' do
      cola.select_button
      expect(cola.selected).to be(true)
    end
  end

  describe '.product_selected?' do
    it 'can detect which products are selected' do
      cola.select_button
      expect(Product.product_selected?).to eq(cola)
    end
  end

  describe '#deselect_button' do
    it 'can deselect a product' do
      cola.select_button
      cola.deselect_button
      expect(cola.selected).to be(false)
    end
  end

  describe '#decrease_product_quantity' do
    it 'can decrease quantity' do
      cola.update(quantity: 6)
      cola.decrease_product_quantity
      expect(cola.quantity).to eq(5)
    end
  end
end
