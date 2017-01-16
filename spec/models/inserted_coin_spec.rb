require 'rails_helper'

RSpec.describe InsertedCoin, type: :model do

  let (:inserted_coins) {InsertedCoin.create}
  let (:dime_1) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_2) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:dime_3) {Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)}
  let (:quarter_1) {Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:quarter_2) {Coin.create(diameter: 0.954, thickness: 0.069, weight: 5.671)}
  let (:nickel) {Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)}
  let (:penny) {Coin.create(diameter: 0.751, weight: 2.500, thickness: 1.52)}

  it 'returns a value of 0 if no coins have been added' do
    expect(inserted_coins.total).to eq(0)
  end

  it 'returns the value of coins when one coin has been added' do
    dime_1.evaluate_coin_values(inserted_coins)
    expect(inserted_coins.total).to eq(0.10)
  end

  it 'returns the value of coins when two different coins have been added' do
    dime_1.evaluate_coin_values(inserted_coins)
    quarter_1.evaluate_coin_values(inserted_coins)
    expect(inserted_coins.total).to eq(0.35)
  end

  it 'returns the value of coins when three different coins have been added' do
    dime_1.evaluate_coin_values(inserted_coins)
    quarter_1.evaluate_coin_values(inserted_coins)
    nickel.evaluate_coin_values(inserted_coins)
    expect(inserted_coins.total).to eq(0.40)
  end

  it 'returns the value of coins when multiple coins of the same kind have been added' do
    dime_1.evaluate_coin_values(inserted_coins)
    dime_2.evaluate_coin_values(inserted_coins)
    quarter_1.evaluate_coin_values(inserted_coins)
    quarter_2.evaluate_coin_values(inserted_coins)
    nickel.evaluate_coin_values(inserted_coins)
    expect(inserted_coins.total).to eq(0.75)
  end
end
