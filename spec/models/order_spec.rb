require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:order) {Order.create}

  it 'creates a new order' do
    expect(order).to be_valid
  end
end
