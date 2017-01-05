require 'rails_helper'

RSpec.describe UserTotalCoin, type: :model do
  let (:total_coins) {UserTotalCoin.create}

  it 'contains a collection of coins' do
    coin_1 = Coin.create(weight: 3.4, thickness: 1.2, diameter: 0.9)
    coin_2 = Coin.create(weight: 8.9, thickness: 3.5, diameter: 1.3)
    total_coins.coins.push(coin_1, coin_2)
    expect(total_coins.coins).to include(coin_1, coin_2)
  end

  it 'can add dimes' do
    total_coins.dime
    expect(total_coins.dimes.length).to eq(1)
  end

  it 'can add nickels' do
    total_coins.nickel
    expect(total_coins.nickels.length).to eq(1)
  end

  it 'can add quarters' do
    total_coins.quarter
    expect(total_coins.quarters.length).to eq(1)
  end

  it 'can identify and add a dime to a user`s total coins' do
    dime = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    total_coins.evaluate_coin_values(dime)
    expect(total_coins.dimes.length).to eq(1)
  end

  it 'can identify and add a nickel to a user`s total coins' do
    nickel = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)
    total_coins.evaluate_coin_values(nickel)
    expect(total_coins.nickels.length).to eq(1)
  end
end
