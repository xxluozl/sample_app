require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # 时区设置成北京
    config.time_zone = "Beijing"
    # 保存到数据库的时间设为本地时间，默认是 :utc
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :cn
    config.i18n.available_locales = %i( cn en )
    config.assets.initialize_on_precompile = false
  end
end
