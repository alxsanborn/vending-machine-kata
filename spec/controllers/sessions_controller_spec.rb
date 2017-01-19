RSpec.describe SessionsController, :type => :routing do
  it "routes to /sessions/new" do
    expect(:get => "/sessions/new").to be_routable
  end
  it "routes to /sessions/create" do
    expect(:post => "/sessions").to be_routable
  end
end
