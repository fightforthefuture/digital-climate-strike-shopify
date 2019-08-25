class UpdateDcsScriptTagVars
  include Callable

  delegate :script_file,
           to: :shop

  def initialize(shop)
    raise "No shop given" unless shop.present?

    @shop = shop
  end

  def call
    record = ShopifyAPI::ScriptTag.
               find(shop.vars_script_tag.to_i)
    record.src = script_file_url
    record.save
    record
  end

  private

  attr_reader :shop

  def script_file_url
    "https://digital-climate-strike.s3.amazonaws.com/#{script_file.attachment.blob.key}"
  end
end
