require 'rubygems'
require 'clockwork'
require 'twitter'
require 'uri'
require 'redis'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

uri = URI.parse ENV['REDISTOGO_URL']
REDIS = Redis.new host: uri.host, port: uri.port, password: uri.password

tweets = ENV['TWEETS'].split ','
from_hour = ENV['FROM_HOUR']
to_hour = ENV['TO_HOUR']

Clockwork.hundler do |job|
  # TODO Implement timer feature
  client.update tweets.sample
end

Clockwork.every 1.minutes, ''
