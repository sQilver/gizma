require 'dotenv'
Dotenv.load

require 'json'
require 'net/http'
require 'pry'
require 'telegram/bot'
require 'uri'
require 'require_all'
require 'selenium-webdriver'


require_all './services'

$rutor_positions = { old_positions: [] }
$youtube_positions = { old_positions: [] }
$errors = {}

$user_list = {'Патреев Игорь' => ENV['MY_CHAT_ID']}
