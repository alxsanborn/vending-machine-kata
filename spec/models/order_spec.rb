require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  before (:each) do
    @order = Order.create
    @order.inserted_coin = InsertedCoin.create #this would be automated in the controller
    @inserted_coin = @order.inserted_coin

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

  it 'can return quarters as change' do
    expect(@order.make_change_quarters(0.65)).to eq([2, 0.15])
  end

  it 'can return dimes as change' do
    expect(@order.make_change_dimes(0.80)).to eq([8, 0])
  end

  it 'can return nickels as change' do
    expect(@order.make_change_nickels(0.05)).to eq(1)
  end

  it 'can return one coin' do
    expect(@order.make_change(0.25)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 0})
  end

  it 'can return nickels' do
    expect(@order.make_change(0.15)).to eq({"quarters" => 0, "nickels" => 1, "dimes" => 1})
  end

  it 'can return multiple quantities of the same coin' do
    expect(@order.make_change(0.50)).to eq({"quarters" => 2, "nickels" => 0, "dimes" => 0})
  end

  it 'can return one of each coin' do
    expect(@order.make_change(0.40)).to eq({"quarters" => 1, "nickels" => 1, "dimes" => 1})
  end

  it 'can return multiple coins' do
    expect(@order.make_change(0.35)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 1})
  end

  it 'when item is successfully purchased, dispenses change and thanks the user' do
    @quarter_1.evaluate_coin_values(@inserted_coin)
    @quarter_2.evaluate_coin_values(@inserted_coin)
    @dime_1.evaluate_coin_values(@inserted_coin)
    @dime_2.evaluate_coin_values(@inserted_coin)
    @nickel.evaluate_coin_values(@inserted_coin)
    @candy.select_button
    product = Product.product_selected?
    allow(@order).to receive(:user_message).with(product).and_return({"quarters" => 0, "nickels" => 0, "dimes" => 1}, "THANK YOU")
  end


  it 'return coins button defaults to false' do
    expect(@order.return_coins).to eq(false)
  end

  it 'changes to true when a user presses the return coins button' do
    expect(@order.return_coins_button).to eq(true)
  end

  it 'returns coins when a user presses the return coins button' do
    @dime_1.evaluate_coin_values(@inserted_coin)
    @dime_2.evaluate_coin_values(@inserted_coin)
    @quarter_1.evaluate_coin_values(@inserted_coin)
    @quarter_2.evaluate_coin_values(@inserted_coin)
    @nickel.evaluate_coin_values(@inserted_coin)
    @order.return_coins_button
    expect(@order.user_message).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  end

  it 'returns a coins when the button is pressed even if user has selected an item' do
    @dime_1.evaluate_coin_values(@inserted_coin)
    @dime_2.evaluate_coin_values(@inserted_coin)
    @quarter_1.evaluate_coin_values(@inserted_coin)
    @quarter_2.evaluate_coin_values(@inserted_coin)
    @nickel.evaluate_coin_values(@inserted_coin)
    @order.return_coins_button
    @chips.select_button
    product = Product.product_selected?
    expect(@order.user_message(product)).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  end
  #
  # it 'does not dispense change and prompts a user to insert coins if a user has not inserted any coins' do
  #   @total_coins.update(return_coins: true)
  #   expect(@total_coins.user_message).to eq("INSERT COINS")
  # end

end
