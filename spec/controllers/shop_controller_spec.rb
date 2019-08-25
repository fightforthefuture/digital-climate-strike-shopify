require 'rails_helper'

describe ShopController, type: :controller do
  let(:double_shopify_api) { double(ShopifyAPI::ScriptTag) }
  let(:shop) { create(:shop) }
  let(:prepare) do
    session[:shopify] = shop.id
    allow(request).to receive(:subdomain).and_return('shopify')
    allow(controller).to receive(:request).and_return(request)
    allow(controller).to receive(:current_shop).and_return(shop)
  end
  let (:shop_params) do
    {
      shop: {
        disable_google_analytics: true,
        force_full_page_widget: true,
        always_show_widget: true,
        show_close_button_on_full_page_widget: true,
        footer_display_start_date: Date.current + 2.days,
        full_page_display_start_date: Date.new(2019, 8, 20) + 10.days,
        iframe_host: "https://assets.fakedigitalclimatestrike.net",
        cookie_expiration_days: 10
      }
    }
  end

  before do
    allow(double_shopify_api).to receive(:id).and_return(12341234)
    allow(double_shopify_api).to receive(:save).and_return(double_shopify_api)
    allow(double_shopify_api).to receive(:src=).and_return(double_shopify_api)
    allow(ShopifyAPI::ScriptTag).to receive(:new).and_return(double_shopify_api)
    allow(ShopifyAPI::ScriptTag).to receive(:find).and_return(double_shopify_api)
    prepare
  end

  describe "#update" do
    context "when there is a current shop" do
      it "updates shop widget customization fields" do
        expect {
          put :update, params: shop_params
          expect(response.status).to eq 200
        }.to change { shop.reload.cookie_expiration_days }.to(10)
      end
    end

    context "when there is no current shop" do
      it "returns :unprocessable_entity" do
        allow(controller).to receive(:current_shop).and_return(nil)
        put :update, params: shop_params
        expect(response.status).to eq 422
      end
    end
  end

  describe "#show" do
    it "return current shop widget customization" do
      get :show
      expect(JSON.parse(response.body)).to eq({
                                                "id" => shop.id,
                                                "type" => "shop",
                                                "attributes" => {
                                                  "always_show_widget" => shop.always_show_widget,
                                                  "disable_google_analytics" => shop.disable_google_analytics,
                                                  "footer_display_start_date" => shop.footer_display_start_date.strftime("%F"),
                                                  "force_full_page_widget" => shop.force_full_page_widget,
                                                  "full_page_display_start_date" => shop.full_page_display_start_date.strftime("%F"),
                                                  "iframe_host" => shop.iframe_host,
                                                  "cookie_expiration_days" => shop.cookie_expiration_days,
                                                  "show_close_button_on_full_page_widget" => shop.show_close_button_on_full_page_widget
                                                }
                                              })
    end
  end
end
