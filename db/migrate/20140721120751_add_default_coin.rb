class AddDefaultCoin < ActiveRecord::Migration
  def change
  	remove_column :users, :coins, :integer
  	add_column :users, :coins, :integer, :default => 1000
  end
end
