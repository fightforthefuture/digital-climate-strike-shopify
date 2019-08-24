require 'rails_helper'

describe HomeController, type: :controller do
  describe "#index" do
    let(:double_shopify_api) { double(ShopifyAPI::ScriptTag) }
    let(:shop) { create(:shop) }
    let(:prepare) do
      session[:shopify] = shop.id
      allow(request).to receive(:subdomain).and_return('shopify')
      allow(controller).to receive(:request).and_return(request)
      allow(controller).to receive(:current_shop).and_return(shop)
    end

    before do
      allow(double_shopify_api).to receive(:save).and_return(true)
      allow(ShopifyAPI::ScriptTag).to receive(:new).and_return(double_shopify_api)
      prepare
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to be 200
    end
  end
end
