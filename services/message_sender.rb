class MessageSender
  MARKDOWN_PARSE_MODE = 'Markdown'.freeze

  def send(text, reply_markup = render_keyboards_buttons)
    $bot.api.send_message(chat_id: $message.chat.id,
                          text: text,
                          reply_markup: reply_markup,
                          parse_mode: MARKDOWN_PARSE_MODE)
  end

  def send_for_users(text, user_list=$user_list, reply_markup = render_keyboards_buttons)
    user_list.each do |_full_user_name, user_chat_id|
      $bot.api.send_message(chat_id: user_chat_id,
                            text: text,
                            reply_markup: reply_markup,
                            parse_mode: MARKDOWN_PARSE_MODE)
    end
  end

  private

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
        KeyboardButton.new('Add me to User list').button,
        KeyboardButton.new('Show User list').button
      ]
    ]

    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons, resize_keyboard: true)
  end

  def render_origin_keyboard
    Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
  end

end
