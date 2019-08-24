class AddWidgetCustomizationParamsToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :disable_google_analytics, :boolean, default: false, null: false
    add_column :shops, :force_full_page_widget, :boolean, default: false, null: false
    add_column :shops, :always_show_widget, :boolean, default: false, null: false
    add_column :shops, :show_close_button_on_full_page_widget, :boolean, default: false, null: false
    add_column :shops, :footer_display_start_date, :date, default: Date.current
    add_column :shops, :full_page_display_start_date, :date, default: Date.new(2019, 8, 20)
    add_column :shops, :iframe_host, :string, default: 'https://assets.digitalclimatestrike.net', null: false
    add_column :shops, :cookie_expiration_days, :integer, default: 1, null: false
    add_column :shops, :uuid, :string
  end
end
