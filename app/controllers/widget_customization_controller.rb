class WidgetCustomizationController < ApplicationController
  def update
    if current_shop.present?
      puts widget_customization_params
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
             :max_cookie_expiration_days,
             :show_close_button_on_full_page_widget)
  end
end
