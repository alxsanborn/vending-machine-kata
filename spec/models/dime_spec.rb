require 'rails_helper'

RSpec.describe Dime, type: :model do
  it 'can create dimes' do
    dime = Dime.create
    expect(dime).to be_valid
  end
end
