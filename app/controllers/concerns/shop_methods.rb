#:nocov:
module ShopMethods
  extend ActiveSupport::Concern

  included do
    def current_shop
      @current_shop ||= if shop_id.present?
                          Shop.find(shop_id)
                        end
    end
    helper_method :current_shop

    private

    def shop_id
      @shop_id ||= session[:shopify]
    end
  end
end
