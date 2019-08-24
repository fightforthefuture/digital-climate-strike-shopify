module ShopMethods
  extend ActiveSupport::Concern

  included do
    def shop_id
      @shop_id ||= session[:shopify]
    end

    def current_shop
      puts shop_id
      @current_shop ||= if shop_id.present?
                          Shop.find(shop_id)
                        else
                          nil
                        end
    end
    helper_method :current_shop
  end
end
