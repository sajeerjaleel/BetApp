class AddCoinsToBetandUser < ActiveRecord::Migration
  def change
  	add_column :bets,  :coins, :integer
  	add_column :users, :coins, :integer
  end
end
