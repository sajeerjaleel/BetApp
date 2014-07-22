class AddDoneToBetMatch < ActiveRecord::Migration
  def change
  	add_column :bet_matches, :done, :boolean,:default => false
  	add_column :bet_fixtures, :result, :string
  end
end
