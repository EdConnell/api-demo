class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def is_current_user?(card)
    card == user
  end

  def find_next_card(last_card)
    card = game.next_card(last_card)
    is_current_user?(card) ? game.next_card(card) : card
  end

  def first_card
    game.next_card
  end

  def is_correct?(card_id, guess)
    game.check_correctness(card_id, guess)
  end
end
