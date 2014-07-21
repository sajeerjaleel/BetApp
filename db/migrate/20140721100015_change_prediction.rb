class ChangePrediction < ActiveRecord::Migration
  def change
  	remove_column :bets, :home, :boolean
  	remove_column :bets, :away, :boolean
  	remove_column :bets, :draw, :boolean
  	add_column    :bets, :prediction, :string
  end
end
