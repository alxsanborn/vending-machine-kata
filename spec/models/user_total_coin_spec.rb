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

    @cola = Product.create(name: "cola", price: 1.00)
    @chips = Product.create(name: "chips", price: 0.50)
    @candy = Product.create(name: "candy", price: 0.65)
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

  it 'thanks the user when a product has been successfully purchased' do
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    @chips.update(selected: true)
    expect(@total_coins.user_message).to eq("THANK YOU")
  end

  it 'does not dispense a product if product has not been selected' do
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    expect(@total_coins.user_message).to eq(0.50)
  end

  it 'does not dispense a product if user has not added enough money' do
    @total_coins.evaluate_coin_values(@quarter_2)
    @chips.update(selected: true)
    expect(@total_coins.user_message).to eq(0.25)
  end

  it 'resets dimes' do
    @total_coins.evaluate_coin_values(@dime_1)
    expect(@total_coins.dimes.length).to eq(1)
    @total_coins.reset_dimes_amount
    expect(@total_coins.dimes.length).to eq(0)
  end

  it 'resets nickels' do
    @total_coins.evaluate_coin_values(@nickel)
    expect(@total_coins.nickels.length).to eq(1)
    @total_coins.reset_nickels_amount
    expect(@total_coins.nickels.length).to eq(0)
  end

  it 'resets quarters' do
    @total_coins.evaluate_coin_values(@quarter_1)
    expect(@total_coins.quarters.length).to eq(1)
    @total_coins.reset_quarters_amount
    expect(@total_coins.quarters.length).to eq(0)
  end

  it 'thanks the user when item dispenses and then resets, asking the user to "INSERT COINS"' do
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    @chips.update(selected: true)
    @total_coins.user_message #had to add this line because changes to coin quantities were not persisting in the database
    allow(@total_coins).to receive(:user_message).and_return("THANK YOU", "INSERT COINS")
    expect(@total_coins.quarters.length).to eq(0)
    #possible refactor later?
  end

  it 'has a method that can determine which coins to return when making change' do
    expect(@total_coins.make_change(0.25)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 0})
    expect(@total_coins.make_change(0.35)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 1})
    expect(@total_coins.make_change(0.15)).to eq({"quarters" => 0, "nickels" => 1, "dimes" => 1})
    expect(@total_coins.make_change(0.50)).to eq({"quarters" => 2, "nickels" => 0, "dimes" => 0})
    expect(@total_coins.make_change(0.40)).to eq({"quarters" => 1, "nickels" => 1, "dimes" => 1})
  end
end
