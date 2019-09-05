module ScriptTagMethods
  extend ActiveSupport::Concern

  included do
    after_create :add_script_tag_to_shopify

    def add_script_tag_to_shopify
      activate_shopify_session
      attach_script_file
      create_dcs_script_tag
      create_dcs_script_tag_vars
      update_shop_script_tag_ids
    end

    def update_script_tag_in_shopify
      activate_shopify_session
      delete_current_script_tags
      add_script_tag_to_shopify
    end

    private

    attr_reader :vars_script_tag_response, :dcs_script_tag_response

    def delete_current_script_tags
      ShopifyAPI::ScriptTag.find(:all).each do |script_tag|
        ShopifyAPI::ScriptTag.delete(script_tag.id)
      end
    end

    def update_shop_script_tag_ids
      update dcs_script_tag: dcs_script_tag_response.id.to_s,
             vars_script_tag: vars_script_tag_response.id.to_s
    end

    def create_dcs_script_tag_vars
      @vars_script_tag_response = CreateDcsScriptTagVars.call self
    end

    def create_dcs_script_tag
      @dcs_script_tag_response = ShopifyAPI::ScriptTag.
                                   new(event: "onload",
                                       src: "https://assets.digitalclimatestrike.net/widget.js")
      @dcs_script_tag_response.save
    end

    def update_dcs_script_tag_vars
      @vars_script_tag_response = UpdateDcsScriptTagVars.call self
    end

    def attach_script_file
      AttachScriptFile.call self
    end
  end
end
