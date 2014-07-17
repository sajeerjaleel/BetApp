class CreateBetFixtures < ActiveRecord::Migration
  def change
    create_table :bet_fixtures do |t|
      t.string :date
      t.string :time
      t.string :home_team
      t.string :away_team
      t.string :location
      t.timestamps
    end
  end
end
