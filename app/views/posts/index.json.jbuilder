json.array!(@posts) do |post|
  json.extract! post, :id, :content, :votes_count, :user_id, :parent_post_id
  json.url post_url(post, format: :json)
end
