class TelegramChatBot
  def run
    Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
      bot.listen do |message|
        worker = create_worker(bot, message)

        $bot = bot
        $message = message

        case message
        when Telegram::Bot::Types::Message
          unless message.photo.empty?
            
           
#            file_id = message.photo.last.file_id
            # bot.api.send_photo(chat_id: message.chat.id, photo: file_id)
#            file_path = bot.api.get_file(file_id: file_id)["result"]["file_path"]
#            photo_url = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_TOKEN']}/#{file_path}"
# binding.pry
            # `sudo wget #{photo_url} -P photos`
            # "sudo -p 'sudo password: ' #{command}"            system("sudo -p 'sudo password: 12345678' wget #{photo_url} -P photos")
          end

#----------------------------------------------------------------------------------------------------------------------#
          if message.text == 'start'
            if worker.status_free?
              worker.run
              send_message("Worker started!")
            else
              send_message("Worker is busy, status: #{worker.status}")
            end
          elsif message.text == 'stop'
            worker.stop
            send_message("Worker stopped, status: #{worker.status}")

          elsif message.text == 'show status'
            send_message("Worker status: #{worker.status}")
          elsif message.text == 'show positions'
            send_message(decorator.positions)
#----------------------------------------------------------------------------------------------------------------------#
          elsif message.text == 'reset errors'
            send_message("Current errors: #{$errors = { youtube: [], rutor: [] }}")
          elsif message.text == 'show errors'
            send_message(decorator.errors)
#----------------------------------------------------------------------------------------------------------------------#
          elsif message.text == 'Show Inline buttons'
            send_message('Inline buttons:', render_inline_buttons)
          elsif message.text == 'Show Origin keyboard'
            send_message('Origin keyboard:', render_origin_keyboard)
          end
#----------------------------------------------------------------------------------------------------------------------#
        when Telegram::Bot::Types::CallbackQuery
          if message.data == 'Inline Button 1_callback'
            bot.api.send_message(chat_id: message.from.id, text: 'Responce text for Inline Button 1')
          elsif message.data == 'Inline Button 2_callback'
            bot.api.send_message(chat_id: message.from.id, text: 'Responce text for Keyboard Button 2')
          elsif message.data == 'Inline Button 3_callback'
            bot.api.send_message(chat_id: message.from.id, text: 'Responce text for Keyboard Button 3')
          end
        end
      end
    end
  end

  private

  def create_worker(bot, message)
    @worker ||= Worker.new(bot, message)
  end

  def render_inline_buttons
    buttons = [
      InlineButton.new('Inline Button 1').button,
      InlineButton.new('Inline Button 2').button,
      InlineButton.new('Inline Button 3').button
    ]

    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
  end

  def render_keyboards_buttons
    buttons = [
      [
        KeyboardButton.new('start').button,
        KeyboardButton.new('stop').button,
        KeyboardButton.new('show status').button,
        KeyboardButton.new('show positions').button
      ],
      [
        KeyboardButton.new('reset errors').button,
        KeyboardButton.new('show errors').button
      ],
      [
        KeyboardButton.new('Show Inline buttons').button,
        KeyboardButton.new('Show Origin keyboard').button
      ]
    ]

    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons, resize_keyboard: true)
  end

  def render_origin_keyboard
    Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  end

  def send_message(text, reply_markup = render_keyboards_buttons)
    $bot.api.send_message(chat_id: $message.chat.id, text: text, reply_markup: reply_markup, parse_mode: 'Markdown')
  end

  def decorator
    @decorator ||= Decorator.new
  end
end
