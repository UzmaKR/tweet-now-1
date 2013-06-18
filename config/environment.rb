# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Consumer & Secret keys are kept in seperate YAML file (& .gitignored!)
config = YAML.load_file(APP_ROOT.join("config", "tweet.yaml"))

config.each do |key, value|
  ENV[key] = value
end


Twitter.configure do |config|
  config.consumer_key = ENV["config.consumer_key"]
  config.consumer_secret = ENV["config.consumer_secret"]
  config.oauth_token = ENV["config.oauth_token"]
  config.oauth_token_secret = ENV["config.oauth_token_secret"]
end