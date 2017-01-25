require "rails_helper"

RSpec.describe CoinsController, :type => :routing do
  it "routes to /coins/:id/edit" do
    expect(:get => "/coins/:id/edit").to be_routable
  end
end
