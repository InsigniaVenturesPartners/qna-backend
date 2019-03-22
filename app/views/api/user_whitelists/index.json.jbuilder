@user_whitelists.each do |user_whitelist|
  json.set! user_whitelist.id do
    json.partial! 'user_whitelist', user_whitelist: user_whitelist
  end
end
