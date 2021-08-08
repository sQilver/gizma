class TelegramChatBot
  def run
    Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN']) do |bot|
      bot.listen do |message|
        $bot = bot
        $message = message

        full_user_name = "#{message.chat.last_name} #{message.chat.first_name}"

        case message
        when Telegram::Bot::Types::Message
          unless message.photo.empty?

            file_id = message.photo.last.file_id
            # if u want responce photo: bot.api.send_photo(chat_id: message.chat.id, photo: file_id)
            file_path = bot.api.get_file(file_id: file_id)["result"]["file_path"]
            photo_url = "https://api.telegram.org/file/bot#{ENV['TELEGRAM_TOKEN']}/#{file_path}"
            system("sudo wget #{photo_url} -P photos")
          end

          #--------------------------------------Processes panel-------------------------------------------------------#
          if message.text == 'start'
            if worker.status_free?
              worker.run
              message_sender.send("Worker started!")
            else
              message_sender.send("Worker is busy, status: #{worker.status}")
            end

          elsif message.text == 'stop'
            if worker.status_free?
              message_sender.send("Worker already stopped!")
            else
              worker.stop
              message_sender.send("Worker stopping started! Wait please!")

              loop do
                sleep 1

                break if  worker.status_free?
              end

              message_sender.send("Worker stopped, status: #{worker.status}")
            end

          elsif message.text == 'show status'
            message_sender.send("Worker status: #{worker.status}")
          elsif message.text == 'show positions'
            message_sender.send(decorator.positions)

            #----------------------------------------Errors panel------------------------------------------------------#
          elsif message.text == 'reset errors'
            message_sender.send("Current errors: #{ $errors = {} }")
          elsif message.text == 'show errors'
            message_sender.send(decorator.errors)

            #---------------------------------------User list panel----------------------------------------------------#
          elsif message.text == 'Add me to User list'
            if $user_list.key?(full_user_name)

              message_sender.send("User #{full_user_name} exist in list!")
            else
              $user_list[full_user_name] = message.chat.id.to_s

              message_sender.send("User #{full_user_name} added to list!")
            end

          elsif message.text == 'Show User list'
            message_sender.send(decorator.user_list)
          end

          #------------------------------------------------------------------------------------------------------------#
          # elsif message.text == 'Show Inline buttons'
          #   message_sender.send('Inline buttons:')
          # elsif message.text == 'Show Origin keyboard'
          #   message_sender.send('Origin keyboard:')
          # end
          #------------------------------------------------------------------------------------------------------------#
        when Telegram::Bot::Types::CallbackQuery
          if message.data == 'Inline Button 1_callback'
            message_sender.send('Responce text for Inline Button 1')
          elsif message.data == 'Inline Button 2_callback'
            message_sender.send('Responce text for Keyboard Button 2')
          elsif message.data == 'Inline Button 3_callback'
            message_sender.send('Responce text for Keyboard Button 3')
          end
        end
      end
    end
  rescue => error
    $status = 'free'
    sleep 3 # тут должно быть значение блольше 1 секунды (это интервал проверки в потоке)
    Error.add_error(error)

    retry
  end

  private

  def worker
    @worker ||= Worker.new
  end

  def decorator
    @decorator ||= Decorator.new
  end

  def message_sender
    @message_sender ||= MessageSender.new
  end
end
