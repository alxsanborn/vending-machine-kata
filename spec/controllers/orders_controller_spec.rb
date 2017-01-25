require "rails_helper"

RSpec.describe OrdersController, :type => :routing do
  it "routes to /orders/new" do
    expect(:get => "/orders/new").to be_routable
  end
end
