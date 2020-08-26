module Selenium
  class Manager
    def initialize(bot, message)
      @bot = bot
      @message = message

      options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
      @driver = Selenium::WebDriver.for :firefox, options: options
    end

    def execute
      check_rutor
      check_youtube
    end

    private

    attr_reader :bot, :message, :driver

    def check_rutor
      driver.navigate.to 'http://rutor.info/browse/0/0/0/4'

      first_line_text = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[2]/td[2]/a[3]').text
      two_line_text   = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[3]/td[2]/a[3]').text
      three_line_text = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[4]/td[2]/a[3]').text
      for_line_text   = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[5]/td[2]/a[3]').text
      five_line_text  = driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[6]/td[2]/a[3]').text

      old_positions = $rutor_positions[:old_positions]

      send_message("New 1 rutor position: #{first_line_text}") unless old_positions.include?(first_line_text)
      send_message("New 2 rutor position: #{two_line_text}")   unless old_positions.include?(two_line_text)
      send_message("New 3 rutor position: #{three_line_text}") unless old_positions.include?(three_line_text)
      send_message("New 4 rutor position: #{for_line_text}")   unless old_positions.include?(for_line_text)
      send_message("New 5 rutor position: #{five_line_text}")  unless old_positions.include?(five_line_text)

      $rutor_positions[1] = first_line_text
      $rutor_positions[2] = two_line_text
      $rutor_positions[3] = three_line_text
      $rutor_positions[4] = for_line_text
      $rutor_positions[5] = five_line_text

      $rutor_positions[:old_positions] << first_line_text unless $rutor_positions[:old_positions].include?(first_line_text)
      $rutor_positions[:old_positions] << two_line_text unless $rutor_positions[:old_positions].include?(two_line_text)
      $rutor_positions[:old_positions] << three_line_text unless $rutor_positions[:old_positions].include?(three_line_text)
      $rutor_positions[:old_positions] << for_line_text unless $rutor_positions[:old_positions].include?(for_line_text)
      $rutor_positions[:old_positions] << five_line_text unless $rutor_positions[:old_positions].include?(five_line_text)
    rescue
    end

    def check_youtube
      driver.navigate.to 'https://www.youtube.com/feed/trending'

      first_line_text = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[1]").text
      two_line_text   = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[3]").text
      three_line_text = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[5]").text
      for_line_text   = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[7]").text
      five_line_text  = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[9]").text

      old_positions = $youtube_positions[:old_positions]

      send_message("New 1 youtube position: #{first_line_text}") unless old_positions.include?(first_line_text)
      send_message("New 2 youtube position: #{two_line_text}")   unless old_positions.include?(two_line_text)
      send_message("New 3 youtube position: #{three_line_text}") unless old_positions.include?(three_line_text)
      send_message("New 4 youtube position: #{for_line_text}")   unless old_positions.include?(for_line_text)
      send_message("New 5 youtube position: #{five_line_text}")  unless old_positions.include?(five_line_text)

      $youtube_positions[1] = first_line_text
      $youtube_positions[2] = two_line_text
      $youtube_positions[3] = three_line_text
      $youtube_positions[4] = for_line_text
      $youtube_positions[5] = five_line_text

      $youtube_positions[:old_positions] << first_line_text unless $youtube_positions[:old_positions].include?(first_line_text)
      $youtube_positions[:old_positions] << two_line_text unless $youtube_positions[:old_positions].include?(two_line_text)
      $youtube_positions[:old_positions] << three_line_text unless $youtube_positions[:old_positions].include?(three_line_text)
      $youtube_positions[:old_positions] << for_line_text unless $youtube_positions[:old_positions].include?(for_line_text)
      $youtube_positions[:old_positions] << five_line_text unless $youtube_positions[:old_positions].include?(five_line_text)
    rescue
    end

    def send_message(text)
      bot.api.send_message(chat_id: message.chat.id, text: text)
    end
  end
end
