require_relative "boot"

require "rails/all"
require "net/http"

Bundler.require(*Rails.groups)

module Currency
  class Application < Rails::Application
    config.load_defaults 5.2
  end
end
