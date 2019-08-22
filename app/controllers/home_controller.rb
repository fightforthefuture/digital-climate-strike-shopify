# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @webhooks = ShopifyAPI::Webhook.find(:all)
  end
end
