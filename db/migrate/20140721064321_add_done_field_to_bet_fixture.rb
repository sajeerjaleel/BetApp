class AddDoneFieldToBetFixture < ActiveRecord::Migration
  def change
  	add_column :bet_fixtures, :bet_created, :boolean,:default => false
  end
end
