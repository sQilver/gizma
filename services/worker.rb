class Worker
  STATUS_FREE = 'free'.freeze
  STATUS_BUSY = 'busy'.freeze

  def initialize
    $status = STATUS_FREE
  end

  def run
    $status = STATUS_BUSY

    Thread.new do
      loop do
        # Here will be logic code
        break if status_free?
      end

      $status = STATUS_FREE
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
end
