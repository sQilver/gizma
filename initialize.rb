require 'dotenv'
require 'json'
require 'net/http'
require 'pry'
require 'telegram/bot'
require 'uri'
require 'require_all'
require 'selenium-webdriver'

require_all './services'

Dotenv.load
