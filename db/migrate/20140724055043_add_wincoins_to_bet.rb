class AddWincoinsToBet < ActiveRecord::Migration
  def change
  	add_column :bets, :coins_won, :integer
  end
end
