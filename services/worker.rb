class Worker
  STATUS_FREE = 'free'.freeze
  STATUS_BUSY = 'busy'.freeze

  def initialize(bot, message)
    $status = STATUS_FREE

    @bot = bot
    @message = message
  end

  def run
    if status_free?

      # Поток нужен для того что бы бот продолжил отвечать на сообщения и в это время выполнялось какое-то действие
      Thread.new do
        $status = STATUS_BUSY

        loop do
          Waiter.wait_for_free_status(60)

          puts 'WORKER RUN PROCESSES IN THREAD!'

          break if status_free?

          dota_manager.execute
          selenium_manager(bot, message).execute

          break if status_free?
        end
      end
    end

  rescue => error
    $status = 'free'
    sleep 10 # тут должно быть значение блольше 1 секунды (это интервал проверки в потоке)
    Error.add_error(error)

    retry
  end

  def stop
    $status = STATUS_FREE
  end

  def status
    $status
  end

  def status_free?
    $status == STATUS_FREE
  end

  def busy?
    $status == STATUS_BUSY
  end

  private

  attr_reader :bot, :message

  def dota_manager
    @dota_manager ||= Dota2::Manager.new
  end

  def selenium_manager(bot, message)
    @selenium_manager ||= Selenium::Manager.new(bot, message)
  end
end
