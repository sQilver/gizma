class TelegramChatBot
  def run
    Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
      bot.listen do |message|
        worker = create_worker(bot, message)

        case message
        when Telegram::Bot::Types::Message
#----------------------------------------------------------------------------------------------------------------------#
          if message.text == 'start'
            if worker.status_free?
              worker.run
              bot.api.send_message(chat_id: message.chat.id,
                                   text: "Worker started, status: #{worker.status}",
                                   reply_markup: render_keyboards_buttons)
            else
              bot.api.send_message(chat_id: message.chat.id,
                                   text: "Worker is busy, status: #{worker.status}",
                                   reply_markup: render_keyboards_buttons)
            end
          elsif message.text == 'stop'
            worker.stop
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "Worker stopped, status: #{worker.status}",
                                 reply_markup: render_keyboards_buttons)
          elsif message.text == 'show status'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "Worker status: #{worker.status}",
                                 reply_markup: render_keyboards_buttons)
#----------------------------------------------------------------------------------------------------------------------#
          elsif message.text == 'reset errors'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "Current errors: #{$errors = { youtube: [], rutor: [] }}",
                                 reply_markup: render_keyboards_buttons)
          elsif message.text == 'show errors'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "Errors: \n"\
                                 "yotube (count: #{$errors[:youtube].count},"\
                                         "list:  #{$errors[:youtube]}) \n" \
                                 "rutor (count: #{$errors[:rutor].count},"\
                                        "list:  #{$errors[:rutor]})",
                                 reply_markup: render_keyboards_buttons)
#----------------------------------------------------------------------------------------------------------------------#
          elsif message.text == 'Show Inline buttons'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: 'Inline buttons:',
                                 reply_markup: render_inline_buttons)
          elsif message.text == 'Show Origin keyboard'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: 'Origin keyboard:',
                                 reply_markup: render_origin_keyboard)
          else
            bot.api.send_message(chat_id: message.chat.id,
                                 text: 'Hi!',
                                 reply_markup: render_keyboards_buttons)
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
        KeyboardButton.new('show status').button
      ],
      [
        KeyboardButton.new('show errors').button,
        KeyboardButton.new('reset errors').button
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
end
