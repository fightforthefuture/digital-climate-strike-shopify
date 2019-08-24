class CreateDcsScriptTagVars
  include Callable

  delegate :script_file,
           to: :shop

  def initialize(shop)
    raise "No shop given" unless shop.present?

    @shop = shop
  end

  def call
    ShopifyAPI::ScriptTag.
      new(event: "onload", src: script_file_url).
      save
  end

  private

  attr_reader :shop

  def script_file_url
    "https://digital-climate-strike.s3.amazonaws.com/#{script_file.attachment.blob.key}"
  end
end
