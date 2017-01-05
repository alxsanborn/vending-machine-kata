require 'rails_helper'

RSpec.describe UserTotalCoin, type: :model do
  it 'contains a collection of coins' do
    coin_1 = Coin.create(weight: 3.4, thickness: 1.2, diameter: 0.9)
    coin_2 = Coin.create(weight: 8.9, thickness: 3.5, diameter: 1.3)
    total_coins = UserTotalCoin.create
    total_coins.coins.push(coin_1, coin_2)
    expect(total_coins.coins).to include(coin_1, coin_2)
  end
end
