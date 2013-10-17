helpers do
  def authenticated?
    !session[:oauth_token].nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def gravatar_icon
    "#{current_user.gravatar_url}?size=40"
  end

  def gravatar_img
   # "#{(person_to_guess?).gravatar_url}?size=300" Will be used for main picture for guessing
  end
end
