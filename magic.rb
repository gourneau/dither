#!/usr/bin/env ruby


require 'oauth'
require 'twitter'


module Magic
  CONSUMER_KEY = '0W95ajy4zYj4C7qcjn1Tg'
  CONSUMER_SECRET = 'bCFVFAWx0WS5NmPBhuxR5u3tiEnftYVXHpKHVB7xZbo'

  def self.to_twitter
    oauth_consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, site: 'http://api.twitter.com', request_endpoint: 'http://api.twitter.com', sign_in: true)
    request_token = oauth_consumer.get_request_token(oauth_callback: 'http://olivebranch.herokuapp.com/')
    request_token
  end

  def self.from_twitter(request_token, oauth_token, oauth_verifier)
    oauth_consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, site: 'http://api.twitter.com', request_endpoint: 'http://api.twitter.com', sign_in: true)
    access_token = request_token.get_access_token(oauth_verifier: oauth_verifier)
    response = oauth_consumer.request(:get, '/account/verify_credentials.json', access_token, { :scheme => :query_string })
    response
  end
end


if __FILE__ == $0
end
