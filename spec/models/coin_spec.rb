require 'rails_helper'

RSpec.describe Coin, type: :model do
  it 'can create a new coin' do
    coin = Coin.create(weight: 8.9, diameter: 4.3, thickness: 6.7)
    expect(coin).to be_valid
  end
end
