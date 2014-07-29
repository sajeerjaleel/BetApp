class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
    	t.string :name
    	t.string :url
    	t.integer :admin_id

      t.timestamps
    end
  end
end
