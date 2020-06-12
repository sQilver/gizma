class KeyboardButton
  def initialize(name)
    @name = name
  end

  def button
    Telegram::Bot::Types::KeyboardButton.new(text: name)
  end

  private

  attr_reader :name
end
