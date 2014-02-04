get '/' do
  @cohorts = Cohort.all
  if authenticated?
    @cohorts.delete_if {|cohort| cohort.name == users_cohort}
  end
  erb :index
end

get '/play' do
  if authenticated?
    @cohort = params[:cohort]
    @game = Game.create(cohort_id: @cohort, user_id: current_user.id)
    @game.set_number_of_cards!
    redirect "/play/#{@game.id}"
  else
    @error = "Error:  Please log in first."
    erb :index
  end
end

get '/play/:game_id' do
  if authenticated?
    @game = Game.find(params[:game_id])
    if @game.user_id != current_user.id || @game.is_finished?
      @error = "Error: This is not your game or the game has already been finished."
      erb :index
    else
      @card = @game.next_card
      @names = (@game.get_names << @card.name).shuffle
      erb :game
    end
  else
    @error = "Error:  Please log in first."
    erb :index
  end
end

post '/play/:game_id' do
  if authenticated?
    @game = Game.find(params[:game_id])
    @guess = params[:guess]
    if @game.user_id != current_user.id
      @error = "Error: This is not your game or the game has already been finished."
      erb :index
    else
      @game.card_check(@guess)
      if @game.is_finished?
        redirect "/gameover"
      else
        redirect "/play/#{@game.id}"
      end
    end
  else
    @error = "Error:  Please log in first."
    erb :index
  end
end

get '/gameover' do
  if authenticated?
    @game = current_user.last_game
    erb :index
  else
    @error = "Error:  Please log in first."
  end
end
