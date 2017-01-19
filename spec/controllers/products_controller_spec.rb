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

  it "routes to /products/create" do
    expect(:post => "/products").to be_routable
  end

  it "does not delete products" do
    expect(:delete => "/products/:id").to_not be_routable
  end
end
