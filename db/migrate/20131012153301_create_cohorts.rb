class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string  :name
      t.integer :socrates_id
    end
  end
end
