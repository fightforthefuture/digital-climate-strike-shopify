class Shop < ApplicationRecord
  include ShopifyApp::SessionStorage
  include ScriptTagMethods

  before_create :set_uuid

  has_one_attached :script_file

  def api_version
    ShopifyApp.configuration.api_version
  end

  private

  def activate_shopify_session
    ShopifyAPI::Base.activate_session shopify_session
    shopify_session
  end

  def disactivate_shopify_session
    ShopifyAPI::Base.clear_session
  end

  def shopify_session
    @shopify_session ||= ShopifyAPI::Session.new domain: shopify_domain,
                                                 token: shopify_token,
                                                 api_version: api_version
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
