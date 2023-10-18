require "rails_helper"

RSpec.describe Account::ProductsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/account/products").to route_to("account/products#index")
    end

    it "routes to #new" do
      expect(get: "/account/products/new").to route_to("account/products#new")
    end

    it "routes to #show" do
      expect(get: "/account/products/1").to route_to("account/products#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/account/products/1/edit").to route_to("account/products#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/account/products").to route_to("account/products#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/account/products/1").to route_to("account/products#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/account/products/1").to route_to("account/products#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/account/products/1").to route_to("account/products#destroy", id: "1")
    end
  end
end
