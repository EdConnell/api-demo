class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :cohort_id
      t.string  :name
      t.string  :gravatar_url
      t.string  :role
    end
  end
end
