class InstagramTag < Tag

  def self.refresh
    trending_tag_names.each do |trending_tag_name|
      where(title: trending_tag_name).first_or_initialize do |tag|
        tag.active_as_of = Time.now
        tag.expires_at ||= Time.now
        tag.expires_at = [tag.active_as_of + 2.hours, tag.expires_at].max
        tag.save!
      end
    end

    Tag.not_expired.each do |tag|
      self.save_media! tag
    end
  end

  def self.save_media!(tag, limit: 10)
    tag_results = Instagram.client.tag_search(tag.title).first(limit)
    tag_result = tag_results.first
    return unless tag_result
    tag_recent_media = Instagram.client.tag_recent_media(tag_result.name)

    tag_recent_media.each do |m|
      %w(image video).each do |content_type|
        if media = m.send(content_type.pluralize)
          status_update = StatusUpdate.where(
            content_type: content_type,
            identity:     m.id,
            provider:     'instagram',
            media_uri:    media.standard_resolution.url
          ).first_or_create!

          tag.status_updates << status_update
        end
      end
    end

    tag.update count: tag_result.media_count
  end

  def self.trending_tag_names
    media_counts = {}

    popular_media_with_tags
      .flat_map(&:tags)
      .sort{ |tag_name|
        media_counts[tag_name] ||= Instagram.client.tag_search(tag_name).first.media_count
      }.first(10)
  end

  def self.popular_media_with_tags
    Instagram.client.media_popular.select{ |m| m.tags.any? }
  end

end
