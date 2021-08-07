require 'dotenv'
Dotenv.load

require 'pry'
require 'yaml'
require 'json'
require 'net/http'
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

options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
$driver = Selenium::WebDriver.for :firefox, options: options

raise 'Precondition Validator Error!' if PreconditionValidator.new.invalid?

YmlManager.new.load_all_positions
