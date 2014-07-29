class CreateUserLeagues < ActiveRecord::Migration
  def change
    create_table :user_leagues do |t|
    	t.belongs_to :league
      t.belongs_to :user
      t.timestamps
    end
  end
end
