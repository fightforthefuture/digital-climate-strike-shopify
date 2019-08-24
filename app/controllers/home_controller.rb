# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    head :ok
  end
end
