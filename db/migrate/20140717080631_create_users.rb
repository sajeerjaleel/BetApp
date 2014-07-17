class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

    	t.string  :first_name
    	t.string  :last_name
    	t.string  :phone
    	t.string  :nick_name
    	t.integer :points

      t.timestamps
    end
  end
end
