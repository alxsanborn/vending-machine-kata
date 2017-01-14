require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  before (:each) do
    @order = Order.create
    @order.inserted_coin = InsertedCoin.create #this would be automated in the controller
    @order.coin_return = CoinReturn.create #this would be automated in the controller

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
end
