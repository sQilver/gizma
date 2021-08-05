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

      message_sender.send_for_users("New 1 rutor position: #{first_line_text}") unless old_positions.include?(first_line_text)
      message_sender.send_for_users("New 2 rutor position: #{two_line_text}")   unless old_positions.include?(two_line_text)
      message_sender.send_for_users("New 3 rutor position: #{three_line_text}") unless old_positions.include?(three_line_text)
      message_sender.send_for_users("New 4 rutor position: #{for_line_text}")   unless old_positions.include?(for_line_text)
      message_sender.send_for_users("New 5 rutor position: #{five_line_text}")  unless old_positions.include?(five_line_text)

      $rutor_positions[1] = first_line_text
      $rutor_positions[2] = two_line_text
      $rutor_positions[3] = three_line_text
      $rutor_positions[4] = for_line_text
      $rutor_positions[5] = five_line_text

      puts "rutor first_line_text- #{first_line_text}"
      puts "rutor two_line_text- #{two_line_text}"
      puts "rutor three_line_text- #{three_line_text}"
      puts "rutor for_line_text- #{for_line_text}"
      puts "rutor five_line_text- #{five_line_text}"   
      
      $rutor_positions[:old_positions] << first_line_text unless $rutor_positions[:old_positions].include?(first_line_text)
      $rutor_positions[:old_positions] << two_line_text unless $rutor_positions[:old_positions].include?(two_line_text)
      $rutor_positions[:old_positions] << three_line_text unless $rutor_positions[:old_positions].include?(three_line_text)
      $rutor_positions[:old_positions] << for_line_text unless $rutor_positions[:old_positions].include?(for_line_text)
      $rutor_positions[:old_positions] << five_line_text unless $rutor_positions[:old_positions].include?(five_line_text)

      yml_manager.save_rutor_positions

    rescue => error
      Error.add_error(error)
    end

    def check_youtube
      
      driver.navigate.to 'https://www.youtube.com/feed/trending'

      first_line_text = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[1]").text
      two_line_text   = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[3]").text
      three_line_text = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[5]").text
      for_line_text   = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[7]").text
      five_line_text  = driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[9]").text

      old_positions = $youtube_positions[:old_positions]

      message_sender.send_for_users("New 1 youtube position: #{first_line_text}") unless old_positions.include?(first_line_text)
      message_sender.send_for_users("New 2 youtube position: #{two_line_text}")   unless old_positions.include?(two_line_text)
      message_sender.send_for_users("New 3 youtube position: #{three_line_text}") unless old_positions.include?(three_line_text)
      message_sender.send_for_users("New 4 youtube position: #{for_line_text}")   unless old_positions.include?(for_line_text)
      message_sender.send_for_users("New 5 youtube position: #{five_line_text}")  unless old_positions.include?(five_line_text)

      $youtube_positions[1] = first_line_text
      $youtube_positions[2] = two_line_text
      $youtube_positions[3] = three_line_text
      $youtube_positions[4] = for_line_text
      $youtube_positions[5] = five_line_text

      puts "youtube first_line_text- #{first_line_text}"
      puts "youtube two_line_text- #{two_line_text}"
      puts "youtube three_line_text- #{three_line_text}"
      puts "youtube for_line_text- #{for_line_text}"
      puts "youtube five_line_text- #{five_line_text}"   

      $youtube_positions[:old_positions] << first_line_text unless $youtube_positions[:old_positions].include?(first_line_text)
      $youtube_positions[:old_positions] << two_line_text unless $youtube_positions[:old_positions].include?(two_line_text)
      $youtube_positions[:old_positions] << three_line_text unless $youtube_positions[:old_positions].include?(three_line_text)
      $youtube_positions[:old_positions] << for_line_text unless $youtube_positions[:old_positions].include?(for_line_text)
      $youtube_positions[:old_positions] << five_line_text unless $youtube_positions[:old_positions].include?(five_line_text)
      
      yml_manager.save_youtube_positions

    rescue => error
      Error.add_error(error)
    end

    def message_sender
      @message_sender ||= MessageSender.new
    end

    def yml_manager
      @yml_manager ||= YmlManager.new
    end
  end
end
