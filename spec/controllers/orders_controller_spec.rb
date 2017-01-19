require "rails_helper"

RSpec.describe OrdersController, :type => :routing do
  it "routes to /orders/:id" do
    expect(:get => "/orders/:id").to be_routable
  end

  it "routes to /orders/new" do
    expect(:get => "/orders/new").to be_routable
  end

  it "routes to /orders/create" do
    expect(:post => "/orders").to be_routable
  end
end