require 'dotenv'
Dotenv.load

require 'yaml'
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
$status = nil

$user_list = { 'Патреев Игорь' => ENV['MY_CHAT_ID'] }

YmlManager.new.load_youtube_positions if YmlManager.new.youtube_file_exist?
YmlManager.new.load_rutor_positions if YmlManager.new.rutor_file_exist?
