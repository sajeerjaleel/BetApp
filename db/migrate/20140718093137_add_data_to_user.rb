class AddDataToUser < ActiveRecord::Migration
  def change
  	add_column :users, :image, :binary
  	add_column :users, :team_id, :integer
  end
end
