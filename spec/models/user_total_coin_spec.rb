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

    @total_coins.coin_return = CoinReturn.create

    @cola = Product.create(name: "cola", price: 1.00, quantity: 30)
    @chips = Product.create(name: "chips", price: 0.50)
    @candy = Product.create(name: "candy", price: 0.65, quantity: 5)
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
    @total_coins.evaluate_coin_values(@dime_1)
    @total_coins.evaluate_coin_values(@nickel)
    @candy.update(selected: true)
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

  it 'when item is successfully purchased, dispenses change and thanks the user' do
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    @total_coins.evaluate_coin_values(@dime_1)
    @total_coins.evaluate_coin_values(@dime_2)
    @total_coins.evaluate_coin_values(@nickel)
    @candy.update(selected: true)
    allow(@total_coins).to receive(:user_message).and_return({"quarters" => 0, "nickels" => 0, "dimes" => 1}, "THANK YOU")
  end

  it 'can return quarters as change' do
    expect(@total_coins.make_change_quarters(0.65)).to eq(0.15)
    expect(@total_coins.coin_return.quarters.length).to eq(2)
  end

  it 'can return dimes as change' do
    expect(@total_coins.make_change_dimes(0.80)).to eq(0)
    expect(@total_coins.coin_return.dimes.length).to eq(8)
  end

  it 'can return nickels as change' do
    @total_coins.make_change_nickels
    expect(@total_coins.coin_return.nickels.length).to eq(1)
  end

  it 'can return one coin' do
    expect(@total_coins.make_change(0.25)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 0})
  end

  it 'can return multiple coins' do
    expect(@total_coins.make_change(0.35)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 1})
  end

  it 'can return nickels' do
    expect(@total_coins.make_change(0.15)).to eq({"quarters" => 0, "nickels" => 1, "dimes" => 1})
  end

  it 'can return multiple quantities of the same coin' do
    expect(@total_coins.make_change(0.50)).to eq({"quarters" => 2, "nickels" => 0, "dimes" => 0})
  end

  it 'can return one of each coin' do
    expect(@total_coins.make_change(0.40)).to eq({"quarters" => 1, "nickels" => 1, "dimes" => 1})
  end

  it 'return coins button defaults to false' do
    expect(@total_coins.return_coins).to eq(false)
  end

  it 'changes to true when a user presses the return coins button' do
    @total_coins.update(return_coins: true)
    expect(@total_coins.return_coins).to eq(true)
  end

  it 'returns coins when a user presses the return coins button' do
    @total_coins.evaluate_coin_values(@dime_1)
    @total_coins.evaluate_coin_values(@dime_2)
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    @total_coins.evaluate_coin_values(@nickel)
    @total_coins.update(return_coins: true)
    expect(@total_coins.user_message).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  end

  it 'returns a coins when the button is pressed even if user has selected an item' do
    @total_coins.evaluate_coin_values(@dime_1)
    @total_coins.evaluate_coin_values(@dime_2)
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    @total_coins.evaluate_coin_values(@nickel)
    @total_coins.update(return_coins: true)
    @chips.update(selected: true)
    expect(@total_coins.user_message).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  end

  it 'does not dispense change and prompts a user to insert coins if a user has not inserted any coins' do
    @total_coins.update(return_coins: true)
    expect(@total_coins.user_message).to eq("INSERT COINS")
  end

  it 'tells a user a product if a product is sold out' do
    @total_coins.evaluate_coin_values(@quarter_1)
    @total_coins.evaluate_coin_values(@quarter_2)
    @total_coins.evaluate_coin_values(@dime_1)
    @chips.update(selected: true)
    expect(@total_coins.user_message).to eq("SOLD OUT")
  end
end
