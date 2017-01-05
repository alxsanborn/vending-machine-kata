require 'rails_helper'

RSpec.describe Penny, type: :model do
  it 'can create pennies' do
    penny = Penny.create
    expect(penny).to be_valid
  end
end
