json.array!(@users) do |user|
  json.extract! user, :id, :userid, :nric, :email, :fullname, :contactno
  json.url user_url(user, format: :json)
end
