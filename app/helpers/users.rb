helpers do
  def authenticated?
    !session[:oauth_token].nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def users_cohort
    current_user.cohort.name
  end

  def gravatar_icon
    "#{current_user.gravatar_url}?size=40"
  end

  def gravatar_img
   "#{@card.gravatar_url}?size=300"
  end

  def has_game_in_session?
    current_user.has_unfinished_game?
  end

  def last_game_id
    current_user.last_game.id
  end
end
