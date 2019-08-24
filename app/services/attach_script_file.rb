class AttachScriptFile
  include Callable

  delegate :uuid,
           :cookie_expiration_days,
           :iframe_host,
           :disable_google_analytics,
           :always_show_widget,
           :force_full_page_widget,
           :show_close_button_on_full_page_widget,
           :footer_display_start_date,
           :full_page_display_start_date,
           :script_file,
           to: :shop

  def initialize(shop)
    raise "No shop given" unless shop.present?

    @shop = shop
  end

  def call
    prepare_temporary_file
    script_file.attach io: File.open(temporary_file.path),
                       filename: "#{uuid}.js",
                       content_type: 'application/javascript'
  ensure
    temporary_file.close
    temporary_file.unlink
  end

  private

  attr_reader :shop, :temporary_file

  def prepare_temporary_file
    @temporary_file = Tempfile.new(["#{uuid}",".js"])
    @temporary_file.write(widget_customization_as_js_content)
    @temporary_file.rewind
  end

  def widget_customization_as_js_content
    "var DIGITAL_CLIMATE_STRIKE_OPTIONS={cookieExpirationDays:#{cookie_expiration_days},iframeHost:'#{iframe_host}',disableGoogleAnalytics:#{disable_google_analytics},alwaysShowWidget:#{always_show_widget},forceFullPageWidget:#{force_full_page_widget},showCloseButtonOnFullPageWidget:#{show_close_button_on_full_page_widget},footerDisplayStartDate: new Date(#{footer_display_start_date.year},#{footer_display_start_date.month},#{footer_display_start_date.day}), fullPageDisplayStartDate: new Date(#{full_page_display_start_date.year},#{full_page_display_start_date.month},#{full_page_display_start_date.day})};"
  end
end
