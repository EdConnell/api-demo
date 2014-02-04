get '/' do
  erb :index
end

get '/play' do
  if current_user
    @cohort = current_user.cohort
    @game = Game.create(cohort_id: @cohort.id, user_id: current_user.id, total_cards: @cohort.student_count - 1)
    redirect "/play/#{@game.id}"
  else
    @error = "Error:  You must first log in before you can play."
    erb :index
  end
end

get '/play/:game_id' do
  @game = Game.find(params[:game_id])
  if @game.user_id != current_user.id || @game.is_finished?
    @error = "Error: This is not your game or game has already been finished."
    erb :index
  else
    @card = @game.next_card
    @names = (@game.get_names << @card.name).shuffle
    erb :game
  end
end

post '/play/:game_id' do
  @game = Game.find(params[:game_id])
  @guess = params[:guess]
  if @game.user_id != current_user.id
    @error = "Error: This is not your game or has already been finished."
    erb :index
  else
    @game.card_check(@guess)
    if @game.is_finished?
      redirect "/gameover"
    else
      redirect "/play/#{@game.id}"
    end
  end
end

get '/gameover' do
  @game = current_user.last_game
  erb :index
end
