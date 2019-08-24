#:nocov:
module SessionRepository
  extend ActiveSupport::Autoload

  autoload :Shop

  class << self
    def store(session)
      ::Shop.store(session)
    end

    def retrieve(id)
      ::Shop.retrieve(id)
    end
  end
end
