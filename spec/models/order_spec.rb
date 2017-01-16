require 'rails_helper'
require 'pry'

RSpec.describe Order, type: :model do
  let (:order) {Order.create}
  let (:inserted_coins) {InsertedCoin.create}
  let (:dime_1) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_2) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_3) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:quarter_1) {Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:quarter_2) {Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:nickel) {Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)}
  let(:cola) {Product.create(name: "cola", price: 1.00, quantity: 30)}
  let(:chips) {Product.create(name: "chips", price: 0.50)}
  let(:candy) {Product.create(name: "candy", price: 0.65, quantity: 5)}

  before (:each) do
    order.inserted_coin = inserted_coins
  end
  
  after(:each) do
    $total_change["quarters"] = 0
    $total_change["dimes"] = 0
    $total_change["nickels"] = 0
  end

  it 'creates a new order' do
    expect(order).to be_valid
  end

  it 'can have inserted coins' do
    expect(order.inserted_coin).to be_an_instance_of(InsertedCoin)
  end

  it 'prompts a user to insert coin if no valid coins have yet been inserted and there are enough coins in the machne to make change' do
    $total_change["quarters"] = 2
    $total_change["dimes"] = 2
    $total_change["nickels"] = 2
    expect(order.user_message).to eq("INSERT COINS")
  end

  it 'returns the current balance if valid coins have been inserted' do
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    expect(order.user_message).to eq(0.5)
  end

  it 'thanks the user when a product has been successfully purchased' do
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    dime_1.evaluate_coin_values(inserted_coins)
    nickel.evaluate_coin_values(inserted_coins)
    candy.select_button
    product = Product.product_selected?
    expect(order.user_message(product)).to eq("THANK YOU")
    expect(product.quantity).to eq(4)
    expect(product.selected).to eq(false)
  end

  it 'does not dispense a product if product has not been selected' do
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    product = Product.product_selected?
    expect(order.user_message(product)).to eq(0.50)
  end

  it 'does not dispense a product if user has not added enough money' do
    quarter_2.evaluate_coin_values(inserted_coins)
    candy.select_button
    product = Product.product_selected?
    expect(order.user_message(product)).to eq(0.25)
    expect(product.quantity).to eq(5)
  end

  it 'can return quarters as change' do
    expect(order.make_change_quarters(0.65)).to eq([2, 0.15])
  end

  it 'can return dimes as change' do
    expect(order.make_change_dimes(0.80)).to eq([8, 0])
  end

  it 'can return nickels as change' do
    expect(order.make_change_nickels(0.05)).to eq(1)
  end

  it 'can return one coin' do
    expect(order.make_change(0.25)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 0})
  end

  it 'can return nickels' do
    expect(order.make_change(0.15)).to eq({"quarters" => 0, "nickels" => 1, "dimes" => 1})
  end

  it 'can return multiple quantities of the same coin' do
    expect(order.make_change(0.50)).to eq({"quarters" => 2, "nickels" => 0, "dimes" => 0})
  end

  it 'can return one of each coin' do
    expect(order.make_change(0.40)).to eq({"quarters" => 1, "nickels" => 1, "dimes" => 1})
  end

  it 'can return multiple coins' do
    expect(order.make_change(0.35)).to eq({"quarters" => 1, "nickels" => 0, "dimes" => 1})
  end

  it 'when item is successfully purchased, dispenses change and thanks the user' do
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    dime_1.evaluate_coin_values(inserted_coins)
    dime_2.evaluate_coin_values(inserted_coins)
    nickel.evaluate_coin_values(inserted_coins)
    candy.select_button
    product = Product.product_selected?
    allow(order).to receive(:user_message).with(product).and_return({"quarters" => 0, "nickels" => 0, "dimes" => 1}, "THANK YOU")
  end


  it 'return coins button defaults to false' do
    expect(order.return_coins).to eq(false)
  end

  it 'changes to true when a user presses the return coins button' do
    expect(order.return_coins_button).to eq(true)
  end

  it 'returns coins when a user presses the return coins button' do
    dime_1.evaluate_coin_values(inserted_coins)
    dime_2.evaluate_coin_values(inserted_coins)
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    nickel.evaluate_coin_values(inserted_coins)
    order.return_coins_button
    expect(order.user_message).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
  end

  it 'returns a coins when the button is pressed even if user has selected an item' do
    dime_1.evaluate_coin_values(inserted_coins)
    dime_2.evaluate_coin_values(inserted_coins)
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    nickel.evaluate_coin_values(inserted_coins)
    order.return_coins_button
    candy.select_button
    product = Product.product_selected?
    expect(order.user_message(product)).to eq({"quarters" => 2, "dimes" => 2, "nickels" => 1})
    expect(product.quantity).to eq(5)
  end

  it 'does not dispense change and prompts a user to insert coins if a user has not inserted any coins and there are enough coins in the machne to make change' do
    $total_change["quarters"] = 2
    $total_change["dimes"] = 2
    $total_change["nickels"] = 2
    order.return_coins_button
    expect(order.user_message).to eq("INSERT COINS")
  end

  it 'tells a user when a product is sold out' do
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    dime_1.evaluate_coin_values(inserted_coins)
    chips.select_button
    product = Product.product_selected?
    expect(order.user_message(product)).to eq("SOLD OUT")
    expect(product.quantity).to eq(0)
  end

  it 'prompts a user to insert exact change only when the machine does not have change' do
    expect(order.user_message).to eq("EXACT CHANGE ONLY")
  end

end
