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

    def neglected_friends(timeline)
      mentions = {}
      timeline.each_with_index do |tweet, index|
        if tweet['text'] =~ /(@[0-9A-Za-z]+)/
          username = $1
          score = timeline.size / (1 + index)
          mentions[username] ||= 0
          mentions[username] += score
        end
      end
      mentions.to_a.sort_by { |username, score| score }.map { |username, score| username }
    end
  end
end
