class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|

    	t.string :date
		  t.string :hometeam
		  t.string :score
		  t.string :awayteam
		  t.string :location
		  
      t.timestamps
    end
  end
end
