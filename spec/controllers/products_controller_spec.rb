require "rails_helper"

RSpec.describe ProductsController, :type => :routing do
  it "routes to /products" do
    expect(:get => "/products").to be_routable
  end

  it "routes to /products/:id" do
    expect(:get => "/products/:id").to be_routable
  end

  it "routes to /products/new" do
    expect(:get => "/products/new").to be_routable
  end
end
