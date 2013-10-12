class Game < ActiveRecord::Base
  belongs_to :cohort
  has_many :users
end
