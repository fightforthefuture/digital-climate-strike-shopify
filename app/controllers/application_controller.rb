class ApplicationController < ShopifyApp::AuthenticatedController
  include ShopMethods

  skip_before_action :verify_authenticity_token
  skip_before_action :login_again_if_different_shop
  skip_around_action :shopify_session

  after_action :allow_shopify_iframe

  private

  def allow_shopify_iframe
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end
end
