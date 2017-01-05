require 'rails_helper'

RSpec.describe Quarter, type: :model do
  it 'can create quarters' do
    quarter = Quarter.create
    expect(quarter).to be_valid
  end
end
