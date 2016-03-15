class TwitterTag < Tag

  def self.refresh
    Rails.configuration.twitter_client.trends(23424977).each do |trend| # US only
      next unless trend.name.start_with?('#') # hashtags only
      trend_name = trend.name[1..-1]
      tag = where(title: trend_name).first_or_initialize
      tag.active_as_of = Time.now
      tag.expires_at ||= Time.now
      tag.expires_at = [tag.active_as_of + 2.hours, tag.expires_at].max
      tag.save!
    end

    Tag.not_expired.each do |tag|
      self.fetch_media_for tag
    end
  end

  def self.fetch_media_for(tag)
    Rails.configuration.twitter_client.search(tag.title).first(10).each do |tweet|
      picture = tweet.media.detect { |m| m.is_a?(Twitter::Media::Photo) }
      next unless picture
      # attach if we find a connection
      status_update = StatusUpdate.where(identity: tweet.id, provider: 'twitter', media_uri: picture.media_uri).first_or_create!
      tag.status_updates << status_update
      tag.save!
    end
  end

end
