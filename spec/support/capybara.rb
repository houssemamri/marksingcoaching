Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: ['--window-size=1440,1024']
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: [:headless, '--window-size=1440,1024']
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

if ENV['HEADED']
  Capybara.current_driver = :chrome
  Capybara.javascript_driver = :chrome
else
  Capybara.javascript_driver = :chrome_headless
end

Capybara.configure do |config|
  config.enable_aria_label = true
end
