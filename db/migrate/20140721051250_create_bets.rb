class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|

    	t.integer :bet_fixture_id
    	t.integer :user_id
    	t.boolean :home
      t.boolean :away
      t.boolean :draw

      t.timestamps
    end
  end
end
