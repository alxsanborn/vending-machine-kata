require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  before (:each) do
    @order = Order.create
    @order.inserted_coin = InsertedCoin.create #this would be automated in the controller
    @order.coin_return = CoinReturn.create #this would be automated in the controller
    @dime_1 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @dime_2 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @dime_3 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @quarter_1 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    @quarter_2 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    @nickel = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)
    @penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 1.52)
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
    @quarter_1.evaluate_coin_values(@order.inserted_coin)
    @quarter_2.evaluate_coin_values(@order.inserted_coin)
    expect(@order.user_message).to eq(0.5)
  end
end
