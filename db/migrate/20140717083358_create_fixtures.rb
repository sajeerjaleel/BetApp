class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|

    	t.string :date 
	 	  t.string :time
	 	  t.string :teams
	 	  t.string :location

      t.timestamps
    end
  end
end
