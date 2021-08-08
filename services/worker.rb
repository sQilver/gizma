class Worker
  STATUS_FREE = 'free'.freeze
  STATUS_BUSY = 'busy'.freeze

  def initialize
    set_status_free
  end

  def run
    if status_free?
      Thread.new do
        puts 'WORKER RUN PROCESSES IN THREAD!'

        set_status_busy

        loop do
          # 300 - every 5 min
          Waiter.wait_for_free_status(5)
          test_process.call

          break if status_free?

          # Waiter.wait_for_free_status(5)
          # rutor_checker.call

          break if status_free?

          # Waiter.wait_for_free_status(5)
          # youtube_checker.call

          break if status_free?

          # Waiter.wait_for_free_status(5)
          # dota2_market_manager.update_status

          break if status_free?
        end

        puts 'WORKER FINISH IN THREAD!'
      end
    end

  rescue => error
    $status = 'free'

    # тут должно быть значение блольше 1 секунды
    # (это интервал проверки в потоке в методе Waiter.wait_for_free_status(60))
    sleep 10
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

  def status_busy?
    $status == STATUS_BUSY
  end

  def set_status_busy
    $status = STATUS_BUSY
  end

  def set_status_free
    $status = STATUS_FREE
  end

  private

  def dota_market_manager
    @dota_market_manager ||= DotaMarketManager.new
  end

  def rutor_checker
    @rutor_checker ||= RutorChecker.new
  end

  def youtube_checker
    @youtube_checker ||= YoutubeChecker.new
  end

  def test_process
    @test_process ||= TestProcess.new
  end
end
