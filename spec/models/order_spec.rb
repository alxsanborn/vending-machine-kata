require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  before (:each) do
    @order = Order.create
    @order.inserted_coin = InsertedCoin.create #this would be automated in the controller
    @inserted_coin = @order.inserted_coin
    @order.coin_return = CoinReturn.create #this would be automated in the controller
    @dime_1 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @dime_2 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @dime_3 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @quarter_1 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    @quarter_2 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    @nickel = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)
    @penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 1.52)

    @cola = Product.create(name: "cola", price: 1.00, quantity: 30)
    @chips = Product.create(name: "chips", price: 0.50)
    @candy = Product.create(name: "candy", price: 0.65, quantity: 5)
  end

  it 'creates a new order' do
    expect(@order).to be_valid
  end

  it 'can have inserted coins' do
    expect(@order.inserted_coin).to be_an_instance_of(InsertedCoin)
  end

  it 'can have a coin return' do
    expect(@order.coin_return).to be_an_instance_of(CoinReturn)
  end

  it 'prompts a user to insert coin if no valid coins have yet been inserted' do
    expect(@order.user_message).to eq("INSERT COINS")
  end

  it 'returns the current balance if valid coins have been inserted' do
    @quarter_1.evaluate_coin_values(@inserted_coin)
    @quarter_2.evaluate_coin_values(@inserted_coin)
    expect(@order.user_message).to eq(0.5)
  end

  it 'thanks the user when a product has been successfully purchased' do
    @quarter_1.evaluate_coin_values(@inserted_coin)
    @quarter_2.evaluate_coin_values(@inserted_coin)
    @dime_1.evaluate_coin_values(@inserted_coin)
    @nickel.evaluate_coin_values(@inserted_coin)
    @candy.select_button
    product = Product.product_selected?
    expect(@order.user_message(product)).to eq("THANK YOU")
    expect(product.selected).to eq(false)
  end

  it 'does not dispense a product if product has not been selected' do
    @quarter_1.evaluate_coin_values(@inserted_coin)
    @quarter_2.evaluate_coin_values(@inserted_coin)
    product = Product.product_selected?
    expect(@order.user_message(product)).to eq(0.50)
  end

  it 'does not dispense a product if user has not added enough money' do
    @quarter_2.evaluate_coin_values(@inserted_coin)
    @candy.select_button
    product = Product.product_selected?
    expect(@order.user_message(product)).to eq(0.25)
  end
end
