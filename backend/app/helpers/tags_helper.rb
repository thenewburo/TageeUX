module TagsHelper

  def tags_and_status_updates(tags)
    tags.map { |t| t.status_updates.limit(5).map { |su| [t, su] } }.flatten(1)
  end

  def media_tag(content_type:, uri:)
    case content_type
    when 'image'
      image_tag(uri, class: "thumbnail")
    when 'video'
      video_tag(uri, controls: true, width: 265)
    end
  end

  def tag_has_chatters?(tag)
    tag.messages
      .select(:user_id).distinct
      .count(:user_id) >= 1
  end

  def ticker_tags(maximum = 40)
    Tag.displayable.limit(maximum)
  end

  def tagspot_tags(maximum)
    Tag.displayable.recently_active
    # tags = conversation_tags.limit(maximum)
    # tag_count = tags.count
    # return tags if tag_count >= maximum
    # collected_ids = tags.pluck(:id)
    # tags + Tag.displayable.recently_active
    #   .where.not(id: collected_ids).limit(maximum - tag_count)
  end

  def conversation_tags
    Tag.has_active_conversation.displayable
  end

end
