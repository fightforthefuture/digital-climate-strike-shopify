class Shop < ApplicationRecord
  include ShopifyApp::SessionStorage

  before_create :set_uuid
  after_create :add_script_tag_to_shopify

  has_one_attached :script_file

  def api_version
    ShopifyApp.configuration.api_version
  end

  def add_script_tag_to_shopify
    activate_shopify_session
    AttachScriptFile.call self
    CreateDcsScriptTagVars.call self
    ShopifyAPI::ScriptTag.
      new(event: "onload", src: "https://assets.digitalclimatestrike.net/widget.js").
      save
  end
  alias :update_script_vars :add_script_tag_to_shopify

  private

  def activate_shopify_session
    ShopifyAPI::Base.activate_session shopify_session
    shopify_session
  end

  def disactivate_shopify_session
    ShopifyAPI::Base.clear_session
  end

  def shopify_session
    @shopify_session ||= ShopifyAPI::Session.new domain: shopify_domain, token: shopify_token, api_version: api_version
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
