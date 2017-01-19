require "rails_helper"

RSpec.describe OrdersController, :type => :routing do
  it "routes to /orders/:id" do
    expect(:get => "/orders/:id").to be_routable
  end
end
