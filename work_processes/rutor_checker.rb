class RutorChecker < BaseWorkProcess
  def call
    $driver.navigate.to 'http://rutor.info/browse/0/0/0/4'

    first_line_text = $driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[2]/td[2]/a[3]').text
    two_line_text = $driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[3]/td[2]/a[3]').text
    three_line_text = $driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[4]/td[2]/a[3]').text
    for_line_text = $driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[5]/td[2]/a[3]').text
    five_line_text = $driver.find_element(xpath: '//*[@id="index"]/table/tbody/tr[6]/td[2]/a[3]').text

    old_positions = $rutor_positions[:old_positions]

    message_sender.send_for_users("New 1 rutor position: #{first_line_text}") unless old_positions.include?(first_line_text)
    message_sender.send_for_users("New 2 rutor position: #{two_line_text}") unless old_positions.include?(two_line_text)
    message_sender.send_for_users("New 3 rutor position: #{three_line_text}") unless old_positions.include?(three_line_text)
    message_sender.send_for_users("New 4 rutor position: #{for_line_text}") unless old_positions.include?(for_line_text)
    message_sender.send_for_users("New 5 rutor position: #{five_line_text}") unless old_positions.include?(five_line_text)

    $rutor_positions[1] = first_line_text
    $rutor_positions[2] = two_line_text
    $rutor_positions[3] = three_line_text
    $rutor_positions[4] = for_line_text
    $rutor_positions[5] = five_line_text

    # puts "Rutor:\n" \
    #        " 1: #{first_line_text}...,\n" \
    #        " 2: #{two_line_text}...,\n" \
    #        " 3: #{three_line_text}...,\n" \
    #        " 4: #{for_line_text}...,\n" \
    #        " 5: #{five_line_text}..."

    $rutor_positions[:old_positions] << first_line_text unless $rutor_positions[:old_positions].include?(first_line_text)
    $rutor_positions[:old_positions] << two_line_text unless $rutor_positions[:old_positions].include?(two_line_text)
    $rutor_positions[:old_positions] << three_line_text unless $rutor_positions[:old_positions].include?(three_line_text)
    $rutor_positions[:old_positions] << for_line_text unless $rutor_positions[:old_positions].include?(for_line_text)
    $rutor_positions[:old_positions] << five_line_text unless $rutor_positions[:old_positions].include?(five_line_text)

    yml_manager.save_rutor_positions

  rescue => error
    Error.add_error(error)
  end
end