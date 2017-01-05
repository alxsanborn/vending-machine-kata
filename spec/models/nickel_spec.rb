require 'rails_helper'

RSpec.describe Nickel, type: :model do
  it 'can create nickels' do
    nickel = Nickel.create
    expect(nickel).to be_valid
  end
end
