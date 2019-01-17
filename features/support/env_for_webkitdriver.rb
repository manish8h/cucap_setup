require 'rspec/expectations'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'pry'
require 'selenium-webdriver'
require 'capybara/webkit'


# # Create target folder
FileUtils.mkdir_p 'target'
File.rename('target/cucumber_statistics/combined_statistics.html', 'target/cucumber_statistics/combined_statistics.1.html') rescue nil

# Give CI more time
Capybara.default_max_wait_time = 10

Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit
Capybara.save_path = 'target/screenshots'
Capybara.default_selector = :css
Capybara.asset_host = 'http://www.google.com'
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara.default_normalize_ws = true


Capybara::Screenshot.register_driver(:webkit) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Webkit.configure do |config|
  config.allow_url("www.google.com")
  config.block_unknown_urls

end

Capybara.default_host = 'http://www.google.com'

