#!/usr/bin/env ruby


require 'oauth'
require 'twitter'


module Magic
  CONSUMER_KEY = '0W95ajy4zYj4C7qcjn1Tg'
  CONSUMER_SECRET = 'bCFVFAWx0WS5NmPBhuxR5u3tiEnftYVXHpKHVB7xZbo'

  def self.get_oauth_url
    oauth_consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, site: 'http://api.twitter.com', request_endpoint: 'http://api.twitter.com', sign_in: true)
    request_token = oauth_consumer.get_request_token(oauth_callback: 'http://olivebranch.herokuapp.com/')
    # puts 'OAuth Token: ' + request_token.token
    # puts 'OAuth Secret: ' + request_token.secret
    # puts 'OAuth URL: ' + request_token.authorize_url
    request_token.authorize_url
  end

  def self.authenticate
    Twitter.configure do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.oauth_token = OAUTH_TOKEN
      config.oauth_token_secret = OAUTH_SECRET
    end
  end

  def self.get_timeline(username)
    timeline = Twitter.user_timeline(username, count: 200)
    loop do
      tweet_count = timeline.count
      begin
        timeline += Twitter.user_timeline(username, count: 200, max_id: timeline.last.id)
      rescue
        break
      end
      break if tweet_count == timeline.count
    end
    timeline
  end
end


if __FILE__ == $0
end
