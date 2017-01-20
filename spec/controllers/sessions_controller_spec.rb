require 'rails_helper'
require 'pry'

RSpec.describe SessionsController, :type => :routing do
  it "routes to /sessions/new" do
    expect(:get => "/sessions/new").to be_routable
  end
  it "routes to /sessions/create" do
    expect(:post => "/sessions").to be_routable
  end
end

RSpec.describe SessionsController, :type => :controller do
  context 'create new session' do
    it "initializes with new order id" do
      expect(Order.count).to eq(0)
      post :create
      expect(request.session["order_id"]).to eq(1)
      expect(Order.count).to eq(1)
    end

    it 'associates inserted coin with order' do
      post :create
      order = Order.find(request.session["order_id"])
      expect(order.inserted_coin).to be_an_instance_of(InsertedCoin)
    end
  end
end
