require 'rails_helper'

describe WidgetCustomizationController, type: :controller do
  describe "#update" do
    let(:double_shopify_api) { double(ShopifyAPI::ScriptTag) }
    let(:shop) { create(:shop) }
    let(:prepare) do
      session[:shopify] = shop.id
      allow(request).to receive(:subdomain).and_return('shopify')
      allow(controller).to receive(:request).and_return(request)
      allow(controller).to receive(:current_shop).and_return(shop)
    end
    let (:widget_customization_params) do
      {
        widget_customization: {
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
      allow(double_shopify_api).to receive(:save).and_return(true)
      allow(ShopifyAPI::ScriptTag).to receive(:new).and_return(double_shopify_api)
      prepare
    end

    context "when there is a current shop" do
      it "updates shop widget customization fields" do
        expect {
          put :update, params: widget_customization_params
          expect(response.status).to eq 200
        }.to change { shop.reload.cookie_expiration_days }.to(10)
      end
    end

    context "when there is no current shop" do
      it "returns :unprocessable_entity" do
        allow(controller).to receive(:current_shop).and_return(nil)
        put :update, params: widget_customization_params
        expect(response.status).to eq 422
      end
    end
  end
end
