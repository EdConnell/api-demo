class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :cohort_id
      t.integer :user_id
      t.integer :score, default: 0
      t.integer :cards_played, default: 0
      t.integer :total_cards
      t.timestamps
    end
  end
end
