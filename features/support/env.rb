require 'rspec/expectations'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'pry'


# DATE FORMATs
# ====================
# Time::DATE_FORMATS[:long_with_sec] = "%b %d, %Y %H:%M:%S"
#
# require 'active_support/core_ext'
require 'selenium-webdriver'
#
# puts "ENV"
# puts Terminal::Table.new rows: ENV.to_h.sort.to_h.select { |key, value| key.to_s.match(/(rvm|KEY|TOKEN|EBA|RUBY|CI)/) }.inject({}) { |h, (k, v)| h[k] = v[0..80]; h }.to_a
# puts "\n\n"
#
# puts "Settings"
# puts Terminal::Table.new rows: [
#                              ['Settings.eba.src_dir', Settings.eba.src_dir],
#                              ['Settings.eba_api_url', Settings.eba_api_url],
#                              ['Settings.eba_ui_url', Settings.eba_ui_url],
#                              ['ENV[\'LOCAL_EBA_TOKEN\']', ENV['LOCAL_EBA_TOKEN']],
#                              ['Settings.eba_intake_api_url', Settings.eba_intake_api_url],
#                              ['ENV[\'LOCAL_INTAKE_TOKEN\']', ENV['LOCAL_INTAKE_TOKEN']],
#                              ['CI', env_ci?]
#                          ]
# puts "\n\n"
#
# # Create target folder
FileUtils.mkdir_p 'target'
File.rename('target/cucumber_statistics/combined_statistics.html', 'target/cucumber_statistics/combined_statistics.1.html') rescue nil

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1920,1080")
  options.add_argument("--no-sandbox")

  # https://github.com/GoogleChrome/puppeteer/blob/14e69d189caa6d2cedbbb00e7698d6454f96b74a/lib/Launcher.js
  options.add_argument("--disable-background-networking")
  options.add_argument("--disable-background-timer-throttling")
  options.add_argument("--disable-breakpad")
  options.add_argument("--disable-client-side-phishing-detection")
  options.add_argument("--disable-default-apps")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-extensions")
  options.add_argument("--disable-features=site-per-process")
  options.add_argument("--disable-hang-monitor")
  options.add_argument("--disable-popup-blocking")
  options.add_argument("--disable-prompt-on-repost")
  options.add_argument("--disable-sync")
  options.add_argument("--disable-translate")
  options.add_argument("--metrics-recording-only")
  options.add_argument("--no-first-run")
  options.add_argument("--safebrowsing-disable-auto-update")

  # Run headless by default unless CHROME_HEADLESS specified
  # To run in browser,
  #
  # CHROME_HEADLESS=false bundle exec cucumber
  unless ENV['CHROME_HEADLESS'] =~ /^(false|no|0)$/i
    options.headless!

    # https://github.com/GoogleChrome/puppeteer/blob/14e69d189caa6d2cedbbb00e7698d6454f96b74a/lib/Launcher.js
    options.add_argument("--hide-scrollbars")
    options.add_argument("--mute-audio")
  end

  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 options: options)
end

# Give CI more time
Capybara.default_max_wait_time = 10

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
Capybara.save_path = 'target/screenshots'
Capybara.default_selector = :css
Capybara.asset_host = 'http://www.google.com'
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara.default_normalize_ws = true

# Capybara does not know that :chrome is a driver. Either we may use :selenium
# as the driver, or explicityly register :chrome as the screenshot driver.
# https://github.com/mattheworiordan/capybara-screenshot/issues/84#issuecomment-41219326
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.default_host = 'http://www.google.com'
