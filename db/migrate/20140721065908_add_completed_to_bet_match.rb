class AddCompletedToBetMatch < ActiveRecord::Migration
  def change
  	add_column :bet_matches, :completed, :boolean,:default => false
  end
end
