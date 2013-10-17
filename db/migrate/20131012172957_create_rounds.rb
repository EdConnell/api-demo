class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :score, default: 0
    end
  end
end
