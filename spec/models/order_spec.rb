require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  before (:each) do
    @order = Order.create
    @order.inserted_coin = InsertedCoin.create #this would be automated in the controller

  end

  it 'creates a new order' do
    expect(@order).to be_valid
  end

  it 'can have inserted coins' do
    expect(@order.inserted_coin).to be_an_instance_of(InsertedCoin)
  end
end
