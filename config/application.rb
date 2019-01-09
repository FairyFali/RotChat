require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RotChat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # 国际化
	# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
	config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
	config.i18n.default_locale = :en

  # 从ActiveRecord中取的时候是本地时间
  config.time_zone = "Beijing" 
  # 存入数据库的时间也是本地时区的时间
  config.active_record.default_timezone = :local 
  # 关闭以UTC格式存入数据库并读取以本地时区格式读取的功能
  config.active_record.time_zone_aware_attributes = false 

  config.assets.paths << Rails.root.join("app", "assets", "fonts")
  
  end
end
