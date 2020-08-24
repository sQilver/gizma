require 'selenium-webdriver'

module Selenium
  class Manager
    def initialize(bot, message)
      @bot = bot
      @message = message

      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--ignore-certificate-errors')
      options.add_argument('--disable-popup-blocking')
      options.add_argument('--disable-translate')
      @driver = Selenium::WebDriver.for :chrome, options: options
    end

    def execute
      driver.navigate.to 'http://rutor.info/browse/0/0/0/4'

      first_line_text = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[2]/td[2]/a[3]').text
      two_line_text = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[3]/td[2]/a[3]').text
      three_line_text = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[4]/td[2]/a[3]').text

      send_message("New 1 position: #{first_line_text}") if $positions[1] != first_line_text
      send_message("New 2 position: #{first_line_text}") if $positions[2] != two_line_text
      send_message("New 3 position: #{first_line_text}") if $positions[3] != three_line_text

      $positions[1] = first_line_text
      $positions[2] = two_line_text
      $positions[3] = three_line_text
    end

    private

    attr_reader :bot, :message, :driver

    def send_message(text)
      bot.api.send_message(chat_id: message.chat.id, text: text)
    end
  end
end
