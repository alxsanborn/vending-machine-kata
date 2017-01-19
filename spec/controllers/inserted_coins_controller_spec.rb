require "rails_helper"

RSpec.describe CoinsController, :type => :routing do
  it "routes to /inserted_coins/:id" do
    expect(:get => "/inserted_coins/:id").to be_routable
  end

  it "routes to /inserted_coins/new" do
    expect(:get => "/inserted_coins/new").to be_routable
  end

  it "routes to /inserted_coins/create" do
    expect(:post => "/inserted_coins").to be_routable
  end

  it "routes to /inserted_coins/:id/edit" do
    expect(:get => "/inserted_coins/:id/edit").to be_routable
  end

  it "edits inserted_coins" do
    expect(:put => "/inserted_coins/:id").to be_routable
  end
end
