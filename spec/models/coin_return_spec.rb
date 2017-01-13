require 'rails_helper'

RSpec.describe CoinReturn, type: :model do
  before (:each) do
    @inserted_coins = UserTotalCoin.create
    @inserted_coins.coin_return = CoinReturn.create
  end

  it 'must belong to a user`s total coins' do
    expect(@inserted_coins.coin_return).to be_an_instance_of(CoinReturn)
  end

  it 'can have many quarters, dimes, and nickels' do
    @quarter_1 = Quarter.create
    @quarter_2 = Quarter.create
    @dime = Dime.create
    @nickel_1 = Nickel.create
    @nickel_2 = Nickel.create
    @nickel_3 = Nickel.create
    @inserted_coins.coin_return.quarters.push(@quarter_1, @quarter_2)
    @inserted_coins.coin_return.dimes.push(@dime)
    @inserted_coins.coin_return.nickels.push(@nickel_1, @nickel_2, @nickel_3)
    expect(@inserted_coins.coin_return.quarters.length).to eq(2)
    expect(@inserted_coins.coin_return.dimes.length).to eq(1)
    expect(@inserted_coins.coin_return.nickels.length).to eq(3)
  end
end
