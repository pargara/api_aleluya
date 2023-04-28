module AuthorizationHelper

 def sign_up(user)
    post '/auth/',
      params: { email: user[:email],
                password: user[:password],
                password_confirmation: user[:password] },
      as: :json
  end

   def auth_headers(user)
    tokens = user.create_new_auth_token
    {
      "access-token": tokens["access-token"],
      "client": tokens["client"],
      "uid": tokens["uid"]
    }
  end

  def auth_tokens_for_user(user)
    post '/auth/sign_in/',
      params: { email: user[:email], password: user[:password] },
      as: :json
    response.headers.slice('client', 'access-token', 'uid')
  end
end
