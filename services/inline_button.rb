class InlineButton
  def initialize(name)
    @name = name
    @callback_data = "#{name}_callback"
  end

  def button
    Telegram::Bot::Types::InlineKeyboardButton.new(text: name, callback_data: callback_data)
  end

  private

  attr_reader :name, :callback_data
end
