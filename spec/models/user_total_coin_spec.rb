require 'rails_helper'

RSpec.describe UserTotalCoin, type: :model do
  before(:each) do
    @total_coins = UserTotalCoin.create
    @dime_1 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @dime_2 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @dime_3 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    @quarter_1 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    @quarter_2 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
    @nickel = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)
    @penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 1.52)
  end

  it 'can add dimes' do
    @total_coins.dime
    expect(@total_coins.dimes.length).to eq(1)
  end

  it 'can add nickels' do
    @total_coins.nickel
    expect(@total_coins.nickels.length).to eq(1)
  end

  it 'can add quarters' do
    @total_coins.quarter
    expect(@total_coins.quarters.length).to eq(1)
  end

  it 'can identify and add a dime to a user`s total coins' do
    @total_coins.evaluate_coin_values(@dime_1)
    expect(@total_coins.dimes.length).to eq(1)
  end

  it 'can identify and add a nickel to a user`s total coins' do
    @total_coins.evaluate_coin_values(@nickel)
    expect(@total_coins.nickels.length).to eq(1)
  end

  it 'can identify and add a quarter to a user`s total coins' do
    @total_coins.evaluate_coin_values(@quarter_1)
    expect(@total_coins.quarters.length).to eq(1)
  end

  it 'can return the total value of coins that a user has inserted' do
        @total_coins.evaluate_coin_values(@dime_1)
        @total_coins.evaluate_coin_values(@dime_2)
        @total_coins.evaluate_coin_values(@dime_3)
        @total_coins.evaluate_coin_values(@quarter_1)
        @total_coins.evaluate_coin_values(@quarter_2)
        @total_coins.evaluate_coin_values(@nickel)
        @total_coins.evaluate_coin_values(@penny)

        expect(@total_coins.total).to eq(0.85)
  end

  it 'prompts a user to insert coin if no valid coins have yet been inserted' do
    expect(@total_coins.user_message).to eq("INSERT COINS")
  end

  it 'returns the value of coins that have been added if valid coins have been inserted' do
    dime_1 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
    quarter_1 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)

    @total_coins.evaluate_coin_values(@dime_1)
    @total_coins.evaluate_coin_values(@quarter_1)

    expect(@total_coins.user_message).to eq(0.35)
  end

  it 'rejects objects with valid diameter and thickness but invalid weight' do
   invalid_dime = Coin.create(weight: 2.500, diameter: 0.705, thickness: 0.053)
   @total_coins.evaluate_coin_values(invalid_dime)
   expect(@total_coins.user_message).to eq("INSERT COINS")
  end

  it 'rejects objects with valid weight and thickness but invalid diameter' do
   invalid_nickel = Coin.create(weight: 5.000, diameter: 3.000, thickness: 1.950)
   @total_coins.evaluate_coin_values(invalid_nickel)
   expect(@total_coins.user_message).to eq("INSERT COINS")
 end

 it 'rejects objects with valid weight and diameter but invalid thickness' do
   invalid_quarter = Coin.create(weight: 5.561, diameter: 0.955, thickness: 0.066)
   @total_coins.evaluate_coin_values(invalid_quarter)
   expect(@total_coins.user_message).to eq("INSERT COINS")
end
end
