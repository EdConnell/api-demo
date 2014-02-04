class Game < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :user

  def cards
    cohort.users.shuffle(random: Random.new(self.id)).delete_if {|card| card.name == self.user.name}
  end

  def next_card
    cards[self.cards_played]
  end

  def card_check(guess)
    if check_correctness(next_card.id, guess)
      self.cards_played += 1
      self.score += 100
      self.save
    else
      self.score -= 50
      self.save
    end
  end

  def check_correctness(card_id, name)
    User.find(card_id).is_this_your_name?(name)
  end

  def is_finished?
    cards_played >= total_cards - 1
  end

  def random_names
  names = Array.new
  until names.length == 3
    names << cards.sample.name
    names = names.uniq
  end
    names
  end

  def get_names
    names = random_names
    until !names.include?(next_card.name)
      names = random_names
    end
    names
  end
end
