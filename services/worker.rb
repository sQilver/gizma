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

      Thread.new do
        $status = STATUS_BUSY

        loop do
          sleep 60

          dota_manager.execute
          selenium_manager(bot, message).execute

          break if status_free?
        end

        $status = STATUS_FREE
      end
    end
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
