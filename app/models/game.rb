class Game < ActiveRecord::Base
  belongs_to :cohort
  has_many :rounds
  has_many :users, through: :rounds
end
