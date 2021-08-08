class PreconditionValidator
  def invalid?
    !valid?
  end

  private

  def valid?
    env_variables_valid? && yml_files_valid?
  end

  def env_variables_valid?
    !ENV['MY_CHAT_ID'].nil? &&
      !ENV['TELEGRAM_TOKEN'].nil? &&
      !ENV['DOTA_MARKET_SECRET_KEY'].nil? &&
      !ENV['TELEGRAM_USER_ID'].nil? &&
      !ENV['SECRET_KEY'].nil?
  end

  def yml_files_valid?
    YmlManager.new.youtube_file_exist? &&
      YmlManager.new.rutor_file_exist?
  end
end
