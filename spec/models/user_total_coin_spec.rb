require 'rails_helper'

RSpec.describe UserTotalCoin, type: :model do
  let (:total_coins) {UserTotalCoin.create}

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

  it 'can identify and add a quarter to a user`s total coins' do
    quarter = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    total_coins.evaluate_coin_values(quarter)
    expect(total_coins.quarters.length).to eq(1)
  end
end
