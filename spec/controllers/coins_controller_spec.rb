require "rails_helper"

RSpec.describe CoinsController, :type => :routing do
  it "routes to /coins/:id" do
    expect(:get => "/coins/:id").to be_routable
  end

  it "routes to /coins/new" do
    expect(:get => "/coins/new").to be_routable
  end

  it "routes to /coins/create" do
    expect(:post => "/coins").to be_routable
  end

  it "routes to /coins/:id/edit" do
    expect(:get => "/coins/:id/edit").to be_routable
  end
end
