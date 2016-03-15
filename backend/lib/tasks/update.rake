task :update_tags => :environment do
  [
    TwitterTag,
    InstagramTag
  ].each do |tag_class|
    puts "Refreshing #{tag_class.to_s.underscore.humanize.pluralize}..."
    tag_class.refresh
  end
end
