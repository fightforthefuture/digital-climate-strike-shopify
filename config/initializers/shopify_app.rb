ShopifyApp.configure do |config|
  config.application_name = "Digital Climate Strike"
  config.api_key = ENV['SHOPIFY_API_KEY']
  config.secret = ENV['SHOPIFY_API_SECRET']
  config.old_secret = ""
  config.scope = "read_content,write_content,read_themes,write_themes,write_script_tags"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2019-07"
  config.session_repository = Shop
end
