require "rails_helper"

RSpec.describe CoinsController, :type => :routing do
  it "routes to /inserted_coins/:id" do
    expect(:get => "/inserted_coins/:id").to be_routable
  end
end
