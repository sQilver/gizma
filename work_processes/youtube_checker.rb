class YoutubeChecker < BaseWorkProcess
  def call
    $driver.navigate.to 'https://www.youtube.com/feed/trending'

    first_line_text = $driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[1]").text
    two_line_text = $driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[3]").text
    three_line_text = $driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[5]").text
    for_line_text = $driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[7]").text
    five_line_text = $driver.find_element(xpath: "(//yt-formatted-string[@class='style-scope ytd-video-renderer'])[9]").text

    old_positions = $youtube_positions[:old_positions]

    message_sender.send_for_users("New 1 youtube position: #{first_line_text}") unless old_positions.include?(first_line_text)
    message_sender.send_for_users("New 2 youtube position: #{two_line_text}") unless old_positions.include?(two_line_text)
    message_sender.send_for_users("New 3 youtube position: #{three_line_text}") unless old_positions.include?(three_line_text)
    message_sender.send_for_users("New 4 youtube position: #{for_line_text}") unless old_positions.include?(for_line_text)
    message_sender.send_for_users("New 5 youtube position: #{five_line_text}") unless old_positions.include?(five_line_text)

    $youtube_positions[1] = first_line_text
    $youtube_positions[2] = two_line_text
    $youtube_positions[3] = three_line_text
    $youtube_positions[4] = for_line_text
    $youtube_positions[5] = five_line_text

    # puts "Youtube:\n" \
    #        " 1: #{first_line_text}...,\n" \
    #        " 2: #{two_line_text}...,\n" \
    #        " 3: #{three_line_text}...,\n" \
    #        " 4: #{for_line_text}...,\n" \
    #        " 5: #{five_line_text}..."

    $youtube_positions[:old_positions] << first_line_text unless $youtube_positions[:old_positions].include?(first_line_text)
    $youtube_positions[:old_positions] << two_line_text unless $youtube_positions[:old_positions].include?(two_line_text)
    $youtube_positions[:old_positions] << three_line_text unless $youtube_positions[:old_positions].include?(three_line_text)
    $youtube_positions[:old_positions] << for_line_text unless $youtube_positions[:old_positions].include?(for_line_text)
    $youtube_positions[:old_positions] << five_line_text unless $youtube_positions[:old_positions].include?(five_line_text)

    yml_manager.save_youtube_positions
  rescue => error
    Error.add_error(error)
  end

  private

  attr_reader :bot, :message
end