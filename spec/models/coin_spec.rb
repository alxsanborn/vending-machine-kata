require 'rails_helper'

RSpec.describe Coin, type: :model do
  it 'can create a new coin' do
    coin = Coin.create(weight: 8.9, diameter: 4.3, thickness: 6.7)
    expect(coin).to be_valid
  end

  it 'requires weight attribute' do
    no_weight = Coin.create(diameter: 3.2, thickness: 0.9)
    expect(no_weight).to_not be_valid
  end
end
