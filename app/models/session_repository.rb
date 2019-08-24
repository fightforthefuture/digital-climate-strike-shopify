module SessionRepository
  extend ActiveSupport::Autoload

  autoload :Shop

  class << self
    def store(*args)
      Shop.store(*args)
    end

    def retrieve(*args)
      Shop.retrieve(*args)
    end
  end
end
