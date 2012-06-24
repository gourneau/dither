#!/usr/bin/env ruby


require 'oauth'
require 'twitter'


module Magic
  CONSUMER_KEY = '0W95ajy4zYj4C7qcjn1Tg'
  CONSUMER_SECRET = 'bCFVFAWx0WS5NmPBhuxR5u3tiEnftYVXHpKHVB7xZbo'

  class << self
    def oauth_consumer
      OAuth::Consumer.new(
        CONSUMER_KEY, CONSUMER_SECRET,
        site: 'http://api.twitter.com',
        request_endpoint: 'http://api.twitter.com',
        sign_in: true)
    end

    def to_twitter
      request_token = oauth_consumer.get_request_token(
        oauth_callback: 'http://olivebranch.herokuapp.com/')
      request_token
    end

    def from_twitter(request_token, oauth_token, oauth_verifier)
      access_token = request_token.get_access_token(oauth_verifier: oauth_verifier)
      request = access_token.request(:get, 'http://api.twitter.com/1/statuses/user_timeline.json?count=200')
      request.body
    end

    def magic(timeline)
      mentions = []
      timeline.each do |tweet|
        if tweet['text'] =~ /([@A-Za-z]+)/
          # TODO: Do something with this username.
          username = $1
          mentions << username
        end
      end
      mentions
    end
  end
end


if __FILE__ == $0
end
