class CreateBetMatches < ActiveRecord::Migration
  def change
    create_table :bet_matches do |t|

    	t.string :bet_fixture_id

      t.timestamps
    end
  end
end
