class Game < ActiveRecord::Base
  belongs_to :cohort
  has_many :rounds
  has_many :users, through: :rounds

  def cards
    cohort.users.shuffle(random: Random.new(self.id))
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
end
