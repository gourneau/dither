require 'twitter'


module Magic
  def self.get_timeline(username)
    timeline = Twitter.user_timeline(username, count: 200)

    loop do
      tweet_count = timeline.count
      begin
        timeline += Twitter.user_timeline(username, count: 200, max_id: timeline.last.id)
      rescue Twitter::Error::BadGateway
      end
      puts timeline.count
      break if tweet_count == timeline.count
    end

    timeline
  end
end
