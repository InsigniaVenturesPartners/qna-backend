export const fetchUserWhitelists = data => (
  $.ajax({
    method: 'GET',
    url: 'api/user_whitelists',
    data
  })
);

export const createUserWhitelist = (email) => (
  $.ajax({
    method: 'POST',
    url: `api/user_whitelists`,
    data: {
      user_whitelist: {
        email
      }
    }
  })
);