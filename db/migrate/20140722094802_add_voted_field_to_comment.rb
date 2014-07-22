class AddVotedFieldToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :user_ids, :integer, array: true, default: []
  end
end
