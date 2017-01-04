require 'rails_helper'

RSpec.describe Coin, type: :model do
  it 'can create a new coin' do
    coin = Coin.create(weight: 8.9, diameter: 4.3, thickness: 6.7)
    expect(coin).to be_valid
  end

  context 'validations' do
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

  context 'identifies coin names by weight, diameter, and thickness attributes' do
    it 'can identify pennies' do
      penny = Coin.create(diameter: 0.751, weight: 2.500, thickness: 0.0598)
      expect(penny.evaluate_coin_values).to eq("penny")
    end

    it 'can identify nickels' do
      nickel = Coin.create(diameter: 0.835, weight: 5.000, thickness: 0.1625)
      expect(nickel.evaluate_coin_values).to eq("nickel")
    end

    it 'can identify dimes' do
      dime = Coin.create(diameter: 0.705, weight: 2.269, thickness: 0.053)
      expect(dime.evaluate_coin_values).to eq("dime")
    end
  end
end
