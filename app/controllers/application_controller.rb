class ApplicationController < ShopifyApp::AuthenticatedController
  include ShopMethods

  skip_before_action :verify_authenticity_token

  after_action :allow_shopify_iframe

  private

  def allow_shopify_iframe
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end
end
