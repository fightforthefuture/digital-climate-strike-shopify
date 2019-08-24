FactoryBot.define do
  factory :shop do
    sequence(:shopify_domain) { |n| "shopify-#{n}.myshopify.com" }
    shopify_token { "74854ed3b786ea36014bea8b5548e253" }
    disable_google_analytics { false}
    force_full_page_widget { false }
    always_show_widget { false }
    show_close_button_on_full_page_widget { false }
    footer_display_start_date { Date.current }
    full_page_display_start_date { Date.new(2019, 8, 20) }
    iframe_host { "https://assets.digitalclimatestrike.net" }
    cookie_expiration_days { 1 }
    uuid { SecureRandom.uuid}
  end
end
