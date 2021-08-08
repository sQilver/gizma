class BaseWorkProcess
  def message_sender
    @message_sender ||= MessageSender.new
  end

  def yml_manager
    @yml_manager ||= YmlManager.new
  end
end