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

end
