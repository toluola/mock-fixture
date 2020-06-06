class CreateFixtures < ActiveRecord::Migration[6.0]
  def change
    create_table :fixtures, id: :uuid do |t|
      t.string :home_team
      t.string :away_team
      t.datetime :date_time

      t.timestamps
    end
  end
end
