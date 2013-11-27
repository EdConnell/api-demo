class Game < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :user

  def cards
    cohort.users.shuffle(random: Random.new(self.id)).delete_if {|card| card.name == user.name}
  end

  def next_card(last_card = -1)
    return self.cards[0] if last_card == -1
    card = cards[last_card_index(last_card) + 1]
  end

  def last_card_index(card)
    cards.index(card)
  end

  def check_correctness(card_id, name)
    User.find(card_id).is_this_your_name?(name)
  end

  def first_card
    next_card
  end

  def is_correct?(card_id, guess)
    check_correctness(card_id, guess)
  end
end
