class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :cohort_id
    end
  end
end
