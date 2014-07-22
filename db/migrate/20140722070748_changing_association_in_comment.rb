class ChangingAssociationInComment < ActiveRecord::Migration
  def change
  	remove_column :comments, :bet_match_id, :integer
  	add_column :comments, :bet_fixture_id, :integer
  end
end
