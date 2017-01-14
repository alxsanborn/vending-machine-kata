require 'rails_helper'

RSpec.describe InsertedCoin, type: :model do
   before(:each) do
     @inserted_coins = InsertedCoin.create
     @dime_1 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
     @dime_2 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
     @dime_3 = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
     @quarter_1 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
     @quarter_2 = Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)
     @nickel = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)
     @penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 1.52)

  #   @total_coins.coin_return = CoinReturn.create
  #
   end

  it 'returns a value of 0 if no coins have been added' do
    expect(@inserted_coins.total).to eq(0)
  end

  it 'returns the value of coins when one coin has been added' do
    @dime_1.evaluate_coin_values(@inserted_coins)
    expect(@inserted_coins.total).to eq(0.10)
  end

  it 'returns the value of coins when two different coins have been added' do
    @dime_1.evaluate_coin_values(@inserted_coins)
    @quarter_1.evaluate_coin_values(@inserted_coins)
    expect(@inserted_coins.total).to eq(0.35)
  end

  it 'returns the value of coins when three different coins have been added' do
    @dime_1.evaluate_coin_values(@inserted_coins)
    @quarter_1.evaluate_coin_values(@inserted_coins)
    @nickel.evaluate_coin_values(@inserted_coins)
    expect(@inserted_coins.total).to eq(0.40)
  end

  it 'returns the value of coins when multiple coins of the same kind have been added' do
    @dime_1.evaluate_coin_values(@inserted_coins)
    @dime_2.evaluate_coin_values(@inserted_coins)
    @quarter_1.evaluate_coin_values(@inserted_coins)
    @quarter_2.evaluate_coin_values(@inserted_coins)
    @nickel.evaluate_coin_values(@inserted_coins)
    expect(@inserted_coins.total).to eq(0.75)
  end
  #
  # it 'when item is successfully purchased, dispenses change and thanks the user' do
  #   @quarter_1.evaluate_coin_values(@total_coins)
  #   @quarter_2.evaluate_coin_values(@total_coins)
  #   @dime_1.evaluate_coin_values(@total_coins)
  #   @dime_2.evaluate_coin_values(@total_coins)
  #   @nickel.evaluate_coin_values(@total_coins)
  #   @candy.update(selected: true)
  #   allow(@total_coins).to receive(:user_message).and_return({"quarters" => 0, "nickels" => 0, "dimes" => 1}, "THANK YOU")
  # end
  #
  # it 'can return quarters as change' do
  #   expect(@total_coins.make_change_quarters(0.65)).to eq(0.15)
  #   expect(@total_coins.coin_return.quarters.length).to eq(2)
  # end
  #
  # it 'can return dimes as change' do
  #   expect(@total_coins.make_change_dimes(0.80)).to eq(0)
  #   expect(@total_coins.coin_return.dimes.length).to eq(8)
  # end
  #
  # it 'can return nickels as change' do
  #   @total_coins.make_change_nickels
  #   expect(@total_coins.coin_return.nickels.length).to eq(1)
  # end
  #
  # it 'can return one coin' do
  #   expect(@total_coins.make_change(0.25)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 0})
  # end
  #
  # it 'can return multiple coins' do
  #   expect(@total_coins.make_change(0.35)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 1})
  # end
  #
  # it 'can return nickels' do
  #   expect(@total_coins.make_change(0.15)).to eq({"quarters" => 0, "nickels" => 1, "dimes" => 1})
  # end
  #
  # it 'can return multiple quantities of the same coin' do
  #   expect(@total_coins.make_change(0.50)).to eq({"quarters" => 2, "nickels" => 0, "dimes" => 0})
  # end
  #
  # it 'can return one of each coin' do
  #   expect(@total_coins.make_change(0.40)).to eq({"quarters" => 1, "nickels" => 1, "dimes" => 1})
  # end
  #
  # it 'return coins button defaults to false' do
  #   expect(@total_coins.return_coins).to eq(false)
  # end
  #
  # it 'changes to true when a user presses the return coins button' do
  #   @total_coins.update(return_coins: true)
  #   expect(@total_coins.return_coins).to eq(true)
  # end
  #
  # it 'returns coins when a user presses the return coins button' do
  #   @dime_1.evaluate_coin_values(@total_coins)
  #   @dime_2.evaluate_coin_values(@total_coins)
  #   @quarter_1.evaluate_coin_values(@total_coins)
  #   @quarter_2.evaluate_coin_values(@total_coins)
  #   @nickel.evaluate_coin_values(@total_coins)
  #   @total_coins.update(return_coins: true)
  #   expect(@total_coins.user_message).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  # end
  #
  # it 'returns a coins when the button is pressed even if user has selected an item' do
  #   @dime_1.evaluate_coin_values(@total_coins)
  #   @dime_2.evaluate_coin_values(@total_coins)
  #   @quarter_1.evaluate_coin_values(@total_coins)
  #   @quarter_2.evaluate_coin_values(@total_coins)
  #   @nickel.evaluate_coin_values(@total_coins)
  #   @total_coins.update(return_coins: true)
  #   @chips.update(selected: true)
  #   expect(@total_coins.user_message).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  # end
  #
  # it 'does not dispense change and prompts a user to insert coins if a user has not inserted any coins' do
  #   @total_coins.update(return_coins: true)
  #   expect(@total_coins.user_message).to eq("INSERT COINS")
  # end
  #
  # it 'tells a user when a product is sold out' do
  #   @quarter_1.evaluate_coin_values(@total_coins)
  #   @quarter_2.evaluate_coin_values(@total_coins)
  #   @dime_1.evaluate_coin_values(@total_coins)
  #   @chips.update(selected: true)
  #   expect(@total_coins.user_message).to eq("SOLD OUT")
  # end
end
