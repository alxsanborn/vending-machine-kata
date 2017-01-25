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
  let (:penny) {Coin.create(diameter: 0.751, weight: 2.500, thickness: 0.0598)}
  let(:cola) {Product.create(name: "cola", price: 1.00, quantity: 30)}
  let(:chips) {Product.create(name: "chips", price: 0.50)}
  let(:candy) {Product.create(name: "candy", price: 0.65, quantity: 5)}

  before do
    order.inserted_coin = inserted_coins
  end

  before(:each) do
    InsertedCoin.machine_quarters = 2
    InsertedCoin.machine_dimes = 2
    InsertedCoin.machine_nickels = 2
  end

  context 'validations' do
    it 'creates a new order' do
      expect(order).to be_valid
    end

    it 'can have inserted coins' do
      expect(order.inserted_coin).to be_an_instance_of(InsertedCoin)
    end
  end

  context 'no valid coins have been added' do
    it 'prompts a user to insert coin if there are enough coins in the machine to make change' do
      expect(order.user_message).to eq("INSERT COINS")
      expect(order.coin_return).to eq("No return change at this time.")
    end

    it 'rejects pennies' do
        penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 0.0598)
        penny.evaluate_coin_values(inserted_coins)
        expect(order.coin_return).to eq("Pennies - 1")
        expect(order.user_message).to eq("INSERT COINS")
        expect(order.inserted_coin.pennies).to eq(0)
    end

    it 'prompts a user to insert exact change only when the machine does not have change' do
      InsertedCoin.machine_quarters = 0
      InsertedCoin.machine_dimes = 0
      InsertedCoin.machine_nickels = 0
      expect(order.user_message).to eq("EXACT CHANGE ONLY")
      expect(order.coin_return).to eq("No return change at this time.")
    end
  end

  context 'valid coins have been added' do
    it 'returns the current balance' do
      quarter_1.evaluate_coin_values(inserted_coins)
      quarter_2.evaluate_coin_values(inserted_coins)
      expect(order.user_message).to eq("0.50")
      expect(order.coin_return).to eq("No return change at this time.")
    end
  end

  context 'making a purchase' do
    it 'does not dispense a product if product has not been selected' do
      quarter_1.evaluate_coin_values(inserted_coins)
      quarter_2.evaluate_coin_values(inserted_coins)
      product = Product.product_selected?
      expect(order.user_message(product)).to eq("0.50")
      expect(order.coin_return).to eq("No return change at this time.")
    end

    it 'does not dispense a product if user has not added enough money' do
      quarter_2.evaluate_coin_values(inserted_coins)
      candy.select_button
      product = Product.product_selected?
      expect(order.user_message(product)).to eq("0.25")
      expect(product.quantity).to eq(5)
      expect(order.coin_return).to eq("No return change at this time.")
    end

    it 'when item is successfully purchased, dispenses change and thanks the user' do
      expect(order.purchased).to eq(false)
      quarter_1.evaluate_coin_values(inserted_coins)
      quarter_2.evaluate_coin_values(inserted_coins)
      dime_1.evaluate_coin_values(inserted_coins)
      dime_2.evaluate_coin_values(inserted_coins)
      nickel.evaluate_coin_values(inserted_coins)
      candy.select_button
      product = Product.product_selected?
      expect(order.coin_return(product)).to eq("Quarters - 0; Dimes - 1; Nickels - 0")
      expect(order.user_message(product)).to eq("THANK YOU")
      expect(order.purchased).to eq(true)
      expect(InsertedCoin.machine_quarters).to eq(4)
      expect(InsertedCoin.machine_dimes).to eq(3)
      expect(InsertedCoin.machine_nickels).to eq(3)
      expect(product.quantity).to eq(4)
      expect(product.selected).to eq(false)
    end

    it 'tells a user when a product is sold out' do
      chips.select_button
      product = Product.product_selected?
      expect(order.user_message(product)).to eq("SOLD OUT")
      expect(product.quantity).to eq(0)
    end
  end

  context 'makes change' do
    it 'can return quarters as change' do
      expect(order.make_change_quarters(0.40)).to eq([1, 0.15])
      expect(InsertedCoin.machine_quarters).to eq(1)
    end

    it 'can return dimes as change' do
      expect(order.make_change_dimes(0.20)).to eq([2, 0])
      expect(InsertedCoin.machine_dimes).to eq(0)
    end

    it 'can return nickels as change' do
      expect(order.make_change_nickels(0.05)).to eq(1)
      expect(InsertedCoin.machine_nickels).to eq(1)
    end

    it 'can return one coin' do
      expect(order.make_change(0.25)).to eq("Quarters - 1; Dimes - 0; Nickels - 0")
      expect(InsertedCoin.machine_quarters).to eq(1)
      expect(InsertedCoin.machine_dimes).to eq(2)
      expect(InsertedCoin.machine_nickels).to eq(2)
    end

    it 'can return nickels' do
      expect(order.make_change(0.15)).to eq("Quarters - 0; Dimes - 1; Nickels - 1")
      expect(InsertedCoin.machine_quarters).to eq(2)
      expect(InsertedCoin.machine_dimes).to eq(1)
      expect(InsertedCoin.machine_nickels).to eq(1)
    end

    it 'can return multiple quantities of the same coin' do
      expect(order.make_change(0.50)).to eq("Quarters - 2; Dimes - 0; Nickels - 0")
      expect(InsertedCoin.machine_quarters).to eq(0)
      expect(InsertedCoin.machine_dimes).to eq(2)
      expect(InsertedCoin.machine_nickels).to eq(2)
    end

    it 'can return one of each coin' do
      expect(order.make_change(0.40)).to eq("Quarters - 1; Dimes - 1; Nickels - 1")
      expect(InsertedCoin.machine_quarters).to eq(1)
      expect(InsertedCoin.machine_dimes).to eq(1)
      expect(InsertedCoin.machine_nickels).to eq(1)
    end

    it 'can return multiple coins' do
      expect(order.make_change(0.35)).to eq("Quarters - 1; Dimes - 1; Nickels - 0")
      expect(InsertedCoin.machine_quarters).to eq(1)
      expect(InsertedCoin.machine_dimes).to eq(1)
      expect(InsertedCoin.machine_nickels).to eq(2)
    end
  end

  context 'refunds' do
    it 'return coins button defaults to false' do
      expect(order.return_coins).to eq(false)
    end

    it 'changes to true when a user presses the return coins button' do
      expect(order.return_coins_button).to eq(true)
    end

    it 'returns coins and resets inserted_coin amounts to 0 when a user presses the return coins button' do
      dime_1.evaluate_coin_values(inserted_coins)
      dime_2.evaluate_coin_values(inserted_coins)
      quarter_1.evaluate_coin_values(inserted_coins)
      quarter_2.evaluate_coin_values(inserted_coins)
      nickel.evaluate_coin_values(inserted_coins)
      order.return_coins_button
      expect(order.coin_return).to eq("Quarters - 2; Dimes - 2; Nickels - 1")
      order.reset_coin_amounts #gets implemented in the controller
      expect(order.inserted_coin.quarters).to eq(0)
      expect(order.inserted_coin.dimes).to eq(0)
      expect(order.inserted_coin.nickels).to eq(0)
      expect(order.user_message).to eq("INSERT COINS")
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
      expect(order.coin_return(product)).to eq("Quarters - 2; Dimes - 2; Nickels - 1")
      expect(order.user_message(product)).to eq("INSERT COINS")
      expect(product.quantity).to eq(5)
    end

    it 'does not dispense change and prompts a user to insert coins if a user has not inserted any coins and there are enough coins in the machine to make change' do
      order.return_coins_button
      expect(order.user_message).to eq("INSERT COINS")
    end

    describe '#reset_coin_amounts' do
      it 'resets inserted_coin amounts to 0 when return coins button has been pressed' do
        dime_1.evaluate_coin_values(inserted_coins)
        quarter_1.evaluate_coin_values(inserted_coins)
        nickel.evaluate_coin_values(inserted_coins)
        order.reset_coin_amounts
        expect(inserted_coins.quarters).to eq(0)
        expect(inserted_coins.dimes).to eq(0)
        expect(inserted_coins.nickels).to eq(0)
      end
    end

    describe '#reset_pennies' do
      it 'deletes pennies from penny count when they have been returned' do
        penny.evaluate_coin_values(inserted_coins)
        order.reset_pennies
        expect(order.inserted_coin.pennies).to eq(0)
      end
    end
  end
end
