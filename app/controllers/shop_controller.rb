class ShopController < AuthenticatedController
  def update
    if current_shop.present?
      current_shop.update widget_customization_params
      current_shop.update_script_vars
      head :ok
    else
      render json: { errors: [
                       {
                         status: "422",
                         source: { pointer: "" },
                         title:  "Invalid Shop",
                         detail: "Shop was not found."
                       }
                     ]
                   },
             status: :unprocessable_entity
    end
  end

  def show
    render json: {
             id: current_shop.id,
             type: "shop",
             attributes: {
               always_show_widget: current_shop.always_show_widget,
               disable_google_analytics: current_shop.disable_google_analytics,
               footer_display_start_date: current_shop.footer_display_start_date.strftime("%F"),
               force_full_page_widget: current_shop.force_full_page_widget,
               full_page_display_start_date: current_shop.full_page_display_start_date.strftime("%F"),
               iframe_host: current_shop.iframe_host,
               cookie_expiration_days: current_shop.cookie_expiration_days,
               show_close_button_on_full_page_widget: current_shop.show_close_button_on_full_page_widget
             }
           },
           status: :ok
  end

  private

  def widget_customization_params
    params.
      required(:widget_customization).
      permit(:always_show_widget,
             :disable_google_analytics,
             :footer_display_start_date,
             :force_full_page_widget,
             :full_page_display_start_date,
             :iframe_host,
             :cookie_expiration_days,
             :show_close_button_on_full_page_widget)
  end
end
