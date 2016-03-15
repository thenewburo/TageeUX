json.messages(@messages) do |message|
  json.(message, :id, :body, :created_at)
  json.login message.user.screen_name
  json.avatar_url message.user.avatar_url
end
