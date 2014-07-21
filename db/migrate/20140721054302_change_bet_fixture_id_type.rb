class ChangeBetFixtureIdType < ActiveRecord::Migration
  def change
  	remove_column :bet_matches, :bet_fixture_id, :string
  	add_column    :bet_matches, :bet_fixture_id, :integer
  end
end
