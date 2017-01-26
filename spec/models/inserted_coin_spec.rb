require 'rails_helper'

RSpec.describe InsertedCoin, type: :model do

  let (:inserted_coins) {InsertedCoin.create}
  let (:dime_1) {Coin.new(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_2) {Coin.new(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_3) {Coin.new(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:quarter_1) {Coin.new(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:quarter_2) {Coin.new(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:nickel) {Coin.new(diameter: 0.835, weight: 5.000, thickness: 0.1625)}
  let (:penny) {Coin.new(diameter: 0.751, weight: 2.500, thickness: 1.52)}

  describe '#total' do
    it 'returns a value of 0 if no coins have been added' do
      expect(inserted_coins.total).to eq(0)
    end

    it 'returns the value of coins when one coin has been added' do
      dime_1.evaluate_coin_values(inserted_coins)
      expect(inserted_coins.total).to eq(0.10)
    end

    it 'returns the value of coins when two different coins have been added' do
      coins = [dime_1, quarter_2]
      coins.each{|coin| coin.evaluate_coin_values(inserted_coins)}
      expect(inserted_coins.total).to eq(0.35)
    end

    it 'returns the value of coins when three different coins have been added' do
      coins = [dime_1, quarter_1, nickel]
      coins.each{|coin| coin.evaluate_coin_values(inserted_coins)}
      expect(inserted_coins.total).to eq(0.40)
    end

    it 'returns the value of coins when multiple coins of the same kind have been added' do
      coins = [dime_1, dime_2, quarter_1, quarter_2, nickel]
      coins.each{|coin| coin.evaluate_coin_values(inserted_coins)}
      expect(inserted_coins.total).to eq(0.75)
    end

    it 'does not add pennies to valid coin total' do
      coins = [dime_1, dime_2, dime_3, quarter_1, quarter_2, nickel, penny]
      coins.each{|coin| coin.evaluate_coin_values(inserted_coins)}
      expect(inserted_coins.total).to eq(0.85)
    end
  end
end
