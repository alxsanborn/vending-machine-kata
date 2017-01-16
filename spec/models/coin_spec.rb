require 'rails_helper'

RSpec.describe Coin, type: :model do

  let (:valid_coins) {InsertedCoin.create}
  let (:dime_1) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_2) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_3) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:quarter_1) {Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:quarter_2) {Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:nickel) {Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)}
  let (:penny) {Coin.create(diameter: 0.751, weight: 2.500, thickness: 0.0598)}

  context 'validations' do
    it 'can create a new coin' do
      expect(dime_1).to be_valid
    end

    it 'requires weight attribute' do
      no_weight = Coin.create(diameter: 3.2, thickness: 0.9)
      expect(no_weight).to_not be_valid
    end

    it 'requires diameter attribute' do
      no_diameter = Coin.create(weight: 3.3, thickness: 4.4)
      expect(no_diameter).to_not be_valid
    end

    it 'requires thickness attribute' do
      no_thickness = Coin.create(weight: 1.2, diameter: 3.4)
      expect(no_thickness).to_not be_valid
    end
  end

  describe "#penny" do
    it 'can add pennies' do
      penny.penny(valid_coins)
      expect(valid_coins.pennies).to eq(1)
    end
  end

  describe "#nickel" do
    it 'can add nickels' do
      nickel.nickel(valid_coins)
      expect(valid_coins.nickels).to eq(1)
    end
  end

  describe "#dime" do
    it 'can add dimes' do
      dime_1.dime(valid_coins)
      expect(valid_coins.dimes).to eq(1)
    end
  end

  describe "#quarter" do
    it 'can add quarters' do
      quarter_1.quarter(valid_coins)
      expect(valid_coins.quarters).to eq(1)
    end
  end

  context 'coin sorting' do
    it 'can identify and add a penny to a user`s total coins' do
      penny.evaluate_coin_values(valid_coins)
      expect(valid_coins.pennies).to eq(1)
    end

    it 'can identify and add a dime to a user`s total coins' do
      dime_1.evaluate_coin_values(valid_coins)
      expect(valid_coins.dimes).to eq(1)
    end

    it 'can identify and add a nickel to a user`s total coins' do
      nickel.evaluate_coin_values(valid_coins)
      expect(valid_coins.nickels).to eq(1)
    end

    it 'can identify and add a quarter to a user`s total coins' do
      quarter_1.evaluate_coin_values(valid_coins)
      expect(valid_coins.quarters).to eq(1)
    end

    it 'rejects objects with valid diameter and thickness but invalid weight' do
     invalid_dime = Coin.create(weight: 2.500, diameter: 0.705, thickness: 0.053)
     invalid_dime.evaluate_coin_values(valid_coins)
     expect(valid_coins.quarters).to eq(0)
     expect(valid_coins.nickels).to eq(0)
     expect(valid_coins.dimes).to eq(0)

    end

    it 'rejects objects with valid weight and thickness but invalid diameter' do
     invalid_nickel = Coin.create(weight: 5.000, diameter: 3.000, thickness: 1.950)
     invalid_nickel.evaluate_coin_values(valid_coins)
     expect(valid_coins.quarters).to eq(0)
     expect(valid_coins.nickels).to eq(0)
     expect(valid_coins.dimes).to eq(0)
    end

    it 'rejects objects with valid weight and diameter but invalid thickness' do
     invalid_quarter = Coin.create(weight: 5.561, diameter: 0.955, thickness: 0.066)
     invalid_quarter.evaluate_coin_values(valid_coins)
     expect(valid_coins.quarters).to eq(0)
     expect(valid_coins.nickels).to eq(0)
     expect(valid_coins.dimes).to eq(0)
    end
  end
end
