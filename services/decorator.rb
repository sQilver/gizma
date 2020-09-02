# To use this mode, pass Markdown in the parse_mode field when using sendMessage.

# Use the following syntax in your message:
# *bold text*
#         _italic text_
#         [text](URL)
#         `inline fixed-width code`
#         ```pre-formatted fixed-width code block```

class Decorator
  def positions
    "*Positions:*\n"\
    "  *Youtube:*\n"\
    "    1 - #{$youtube_positions[1]}\n"\
    "    2 - #{$youtube_positions[2]}\n"\
    "    3 - #{$youtube_positions[3]}\n"\
    "    4 - #{$youtube_positions[4]}\n"\
    "    5 - #{$youtube_positions[5]}\n"\
    "  *Rutor:*\n"\
    "    1 - #{$rutor_positions[1]}\n"\
    "    2 - #{$rutor_positions[2]}\n"\
    "    3 - #{$rutor_positions[3]}\n"\
    "    4 - #{$rutor_positions[4]}\n"\
    "    5 - #{$rutor_positions[5]}\n"\
  end

  def errors
    "*Errors:*\n"\
    "  Yotube (count: #{$errors[:youtube].count},list: #{$errors[:youtube]}) \n"\
    "  Rutor (count: #{$errors[:rutor].count},list: #{$errors[:rutor]})"
    "  Reconnect (count: #{$errors[:reconnect].count},list: #{$errors[:reconnect]})"
  end
end
