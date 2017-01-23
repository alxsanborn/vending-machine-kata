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

  it "routes to /products/:id/edit" do
    expect(:get => "/products/:id/edit").to be_routable
  end

  it "edits a product" do
    expect(:put => "/products/:id").to be_routable
  end

  it 'root renders the :index template' do
    expect(:get => '/').to route_to(
      controller: "products",
      action: "index"
    )
  end
end

RSpec.describe ProductsController, :type => :controller do
  describe "GET index" do
    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
      expect(request.session[:order_id]).to be_an_instance_of(Order)
      expect(request.session[:order_id].inserted_coin).to be_an_instance_of(InsertedCoin)
    end
  end

end
