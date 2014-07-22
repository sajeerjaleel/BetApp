class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.references :user
    	t.references :bet_match
			t.string :content
			t.integer :like, default: 0
			t.integer :dislike, default: 0    	
      t.timestamps
    end
  end
end
