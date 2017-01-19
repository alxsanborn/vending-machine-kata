require "rails_helper"

RSpec.describe ProductsController, :type => :routing do
  it "routes to /products" do
    expect(:get => "/products").to be_routable
  end
end
