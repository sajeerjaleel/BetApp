class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|

    	t.string :position
	 	  t.string :team
	 	  t.string :played
	 	  t.string :won
	    t.string :drawn
	    t.string :lost
	 	  t.string :goalfor
	 	  t.string :goalagainst
	 	  t.string :goaldifference
	 	  t.string :points

      t.timestamps
    end
  end
end
