json.users do
  json.id @user.id
  json.avatar_url @user.avatar_url
  json.nickname @user.nickname
end